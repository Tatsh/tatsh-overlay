# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	avt@0.17.0
	bytemuck@1.24.0
	cfg-if@1.0.4
	crc32fast@1.5.0
	equivalent@1.0.2
	flate2@1.1.9
	hashbrown@0.16.0
	heck@0.5.0
	indexmap@2.12.0
	inventory@0.3.21
	libloading@0.8.9
	miniz_oxide@0.8.9
	proc-macro2@1.0.103
	quote@1.0.41
	regex-lite@0.1.8
	rgb@0.8.52
	rustler@0.37.0
	rustler_codegen@0.37.0
	rustversion@1.0.22
	simd-adler32@0.3.8
	syn@2.0.108
	unicode-ident@1.0.20
	unicode-width@0.1.14
	windows-link@0.2.1
	zlib-rs@0.6.0
"

RUST_MIN_VER="1.82.0"

inherit cargo edo systemd

DISTFILES_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__"
# Hex is a Mix archive that mix installs by downloading it, and mix cannot read
# a lock file full of :hex entries without it.
HEX_PV="2.5.1"

DESCRIPTION="Platform for hosting and sharing terminal session recordings."
HOMEPAGE="https://asciinema.org https://github.com/asciinema/asciinema-server"
# Mix and npm both resolve over the network, so the dependency trees are
# fetched ahead of time and shipped whole. The Rust crates come from CRATES.
SRC_URI="
	${CARGO_CRATE_URIS}
	${DISTFILES_URI}/hex-${HEX_PV}-mix-home.tar.xz
	${DISTFILES_URI}/${P}-deps.tar.xz
	${DISTFILES_URI}/${P}-node_modules.tar.xz
	https://github.com/asciinema/${PN}/archive/refs/tags/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"
S="${WORKDIR}/${PN}-${PV}"

# Apache-2.0 is upstream's own. The rest cover the crates linked into the
# three Rust NIFs under native/.
LICENSE="Apache-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/asciinema
	acct-user/asciinema
	dev-lang/elixir
	dev-lang/erlang
	dev-db/postgresql
"
BDEPEND="
	dev-lang/elixir
	dev-lang/erlang
	dev-util/esbuild:*
	dev-util/tailwindcss
"

PATCHES=(
	"${FILESDIR}/${P}-security-updates.patch"
	"${FILESDIR}/${P}-system-tooling.patch"
)

# The release is a self contained tree of beam files, so there is nothing for
# the usual QA checks to look at, and it keeps its own debug information.
QA_PREBUILT="usr/libexec/${PN}/.*"

src_unpack() {
	cargo_src_unpack
}

src_prepare() {
	default

	# The two vendored trees unpack at the top of WORKDIR; mix and the asset
	# build expect them inside the source tree.
	rm -rf deps assets/node_modules || die
	mv "${WORKDIR}/deps" deps || die
	mv "${WORKDIR}/node_modules" assets/node_modules || die
}

src_compile() {
	local -x MIX_ENV=prod
	# Neither tool may reach the network, and neither may write outside the
	# build directory.
	local -x HEX_OFFLINE=1
	local -x HEX_HOME="${T}/hex" MIX_HOME="${WORKDIR}/mix-home"
	local -x HOME="${T}"
	# dev-util/esbuild is slotted by version and installs esbuild-${PV} with no
	# unversioned symlink, so pick the newest one that is installed.
	local esbuild
	esbuild="$(find "${ESYSROOT}/usr/bin" -maxdepth 1 -name 'esbuild-*' -type f |
		sort -V | tail -n1)"
	[[ -x ${esbuild} ]] || die "no esbuild binary in ${ESYSROOT}/usr/bin"
	local -x ESBUILD_PATH="${esbuild}"
	local -x TAILWIND_PATH="${ESYSROOT}/usr/bin/tailwindcss"

	edo mix deps.compile --no-deps-check
	edo mix compile --no-deps-check
	edo mix assets.deploy
	edo mix release --no-deps-check
}

src_install() {
	# Copied rather than installed with doins, which drops the executable bit.
	# The release needs it on nine files, and not only the obvious ones: the
	# launchers in bin/, releases/*/elixir and releases/*/iex, which have no
	# extension, and two helper scripts under lib/*/priv.
	dodir "/usr/libexec/${PN}"
	cp -a "_build/prod/rel/asciinema/." "${ED}/usr/libexec/${PN}/" || die

	# The release ships a Windows launcher alongside the shell one.
	rm "${ED}/usr/libexec/${PN}/bin/asciinema.bat" || die

	# systemd reads EnvironmentFile as root before switching to User=, so the
	# secrets in here never need to be readable by the service account.
	insinto "/etc/${PN}"
	newins "${FILESDIR}/server.env" server.env
	fperms 0600 "/etc/${PN}/server.env"

	# StateDirectory= in the unit creates /var/lib/${PN} and gives it to the
	# service account on first start, so it is not shipped here.
	systemd_dounit "${FILESDIR}/${PN}.service"

	dodoc README.md
}

pkg_postinst() {
	elog "Before starting the service:"
	elog
	elog "  1. Create the database and role:"
	elog "       createuser asciinema"
	elog "       createdb -O asciinema asciinema"
	elog "  2. Put SECRET_KEY_BASE, DATABASE_URL and URL_HOST in"
	elog "       /etc/${PN}/server.env"
	elog "     Generate the secret with: openssl rand -base64 48"
	elog
	elog "The unit runs bin/migrate before bin/server, so the schema is"
	elog "created and updated for you."
	elog
	ewarn "Two of the locked dependencies carry published advisories that"
	ewarn "cannot be resolved by updating them:"
	ewarn
	ewarn "  cowlib 2.20.0 (EEF-CVE-2026-43966, -43969, -43971)"
	ewarn "    Header and cookie injection in the HTTP layer. No fixed"
	ewarn "    release exists; 2.20.0 is the newest published."
	ewarn "  earmark 1.4.49 (EEF-CVE-2026-48591)"
	ewarn "    Stored XSS through unescaped attribute values. The package is"
	ewarn "    retired. Rendered markdown is passed through"
	ewarn "    HtmlSanitizeEx.basic_html/1 here, which allowlists attributes,"
	ewarn "    so the path is mitigated."
	ewarn
	ewarn "Consider whether to expose this server directly to the internet."
}
