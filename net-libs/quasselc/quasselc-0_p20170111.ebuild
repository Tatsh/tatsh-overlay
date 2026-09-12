# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

MY_PN="QuasselC"
MY_COMMIT="a0a1e6bd87d3eac68b5369972d1c2035cfe47e94"

DESCRIPTION="API to access a Quassel core in pure C."
HOMEPAGE="https://github.com/phhusson/QuasselC"
SRC_URI="https://github.com/phhusson/${MY_PN}/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	virtual/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${P}-respect-flags.patch" )

src_compile() {
	# The default target also builds bot, a demo client that is linked with
	# -Wl,-rpath,. and is not installed. VERSION is hardcoded to 0 upstream.
	emake CC="$(tc-getCC)" prefix=/usr "libdir=/usr/$(get_libdir)" \
		includedir=/usr/include libquasselc.so.0 quasselc.pc
}

src_install() {
	emake DESTDIR="${D}" prefix=/usr "libdir=/usr/$(get_libdir)" \
		includedir=/usr/include install

	einstalldocs
}
