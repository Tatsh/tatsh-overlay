# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod systemd

DESCRIPTION="Sync server and web client for Actual, a local-first personal finance app"
HOMEPAGE="https://actualbudget.org https://github.com/actualbudget/actual"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

RDEPEND="acct-group/actual
	acct-user/actual
	>=net-libs/nodejs-22:="
DEPEND="${RDEPEND}"

src_prepare() {
	nodejs-mod_src_prepare
	# Gentoo's compiler already defines _FORTIFY_SOURCE, which argon2 redefines; drop -Werror.
	sed -e 's/, "-Werror"//' -i node_modules/argon2/binding.gyp || die
	grep -q -- '-Werror' node_modules/argon2/binding.gyp && die "failed to remove -Werror"
}

src_compile() {
	nodejs-mod_src_compile
	# The eclass does not stop when an addon fails to build.
	local addon
	for addon in argon2/build/Release/argon2 bcrypt/build/Release/bcrypt_lib \
		better-sqlite3/build/Release/better_sqlite3; do
		[[ -f node_modules/${addon}.node ]] || die "${addon%%/*} native addon failed to build"
	done
}

src_install() {
	nodejs-mod_src_install
	local bin
	bin="/usr/$(get_libdir)/node_modules/${PN}/node_modules/@actual-app/sync-server/build/bin/actual-server.js"
	fperms 0755 "${bin}"
	dosym "../${bin#/usr/}" /usr/bin/actual-server
	newinitd "${FILESDIR}/${PN}.initd" "${PN}"
	newconfd "${FILESDIR}/${PN}.confd" "${PN}"
	systemd_dounit "${FILESDIR}/${PN}.service"
}
