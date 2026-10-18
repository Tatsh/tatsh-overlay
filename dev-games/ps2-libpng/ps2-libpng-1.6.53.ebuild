# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ps2-port

DESCRIPTION="PNG library for the PlayStation 2"
HOMEPAGE="https://www.libpng.org/ https://github.com/ps2dev/ps2sdk-ports"
SRC_URI="https://github.com/pnggroup/libpng/archive/refs/tags/v${PV}.tar.gz -> libpng-${PV}.tar.gz"
S="${WORKDIR}/libpng-${PV}"

LICENSE="libpng2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-games/ps2-zlib"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DPNG_SHARED=OFF
		-DPNG_STATIC=ON
		-DPNG_TESTS=OFF
		-DPNG_TOOLS=OFF
	)
	ps2-port_src_configure
}

src_install() {
	ps2-port_src_install
	# pkg-config users look for the versioned name.
	dosym libpng.a "${PS2_PORTS}/lib/libpng16.a"
}
