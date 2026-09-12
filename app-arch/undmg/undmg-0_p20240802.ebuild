# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="0d92602b694f810fa4b137d87c743f345b303a14"

DESCRIPTION="Extract the contents of an Apple DMG disk image."
HOMEPAGE="https://github.com/matthewbauer/undmg"
SRC_URI="https://github.com/matthewbauer/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	dev-libs/lzfse
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Gentoo's app-arch/bzip2 ships no pkg-config file.
	# shellcheck disable=SC2016
	sed -i -e 's|$(shell $(PKG_CONFIG) --libs bzip2)|-lbz2|' \
		-e 's|$(shell $(PKG_CONFIG) --cflags bzip2)||' Makefile || die

	# Upstream lists the libraries before the objects, which fails to link
	# under --as-needed.
	# shellcheck disable=SC2016
	sed -i -e 's|$(LDFLAGS) $(LIB) $^|$(LDFLAGS) $^ $(LIB)|' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} $($(tc-getPKG_CONFIG) --cflags zlib)" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
