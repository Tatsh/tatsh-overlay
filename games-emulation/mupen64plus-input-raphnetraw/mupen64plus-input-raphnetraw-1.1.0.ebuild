# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Plugin to let the emulator communicate with the controllers directly."
HOMEPAGE="https://www.raphnet-tech.com/products/raphnetraw/index.php"
SRC_URI="https://www.raphnet-tech.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-libs/hidapi media-libs/libsdl2"
RDEPEND="${DEPEND}"

src_prepare() {
	touch src/config.h
	sed -e '99s/^LDLIBS +=.*/LDLIBS += -lm -lSDL2/' -i projects/unix/Makefile
	default
}

src_compile() {
	cd projects/unix
	emake OPTFLAGS="${CFLAGS}" WARNFLAGS= all
}

src_install() {
	insinto /usr/$(get_libdir)/mupen64plus
	doins projects/unix/${PN}.so
	einstalldocs
}
