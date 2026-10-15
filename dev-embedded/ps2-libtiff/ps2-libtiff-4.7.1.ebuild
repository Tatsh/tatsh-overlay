# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ps2-port

DESCRIPTION="TIFF library for the PlayStation 2"
HOMEPAGE="https://libtiff.gitlab.io/libtiff/ https://github.com/ps2dev/ps2sdk-ports"
SRC_URI="https://download.osgeo.org/libtiff/tiff-${PV}.tar.xz"
S="${WORKDIR}/tiff-${PV}"

LICENSE="libtiff"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-embedded/ps2-libjpeg-turbo
	dev-embedded/ps2-zlib
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		# newlib has no lfind.
		-DCMAKE_C_FLAGS=-Dlfind=bsearch
		-Djbig=OFF
		-Djpeg=ON
		-Dlerc=OFF
		-Dlibdeflate=OFF
		-Dlzma=OFF
		-Dtiff-contrib=OFF
		-Dtiff-docs=OFF
		-Dtiff-tests=OFF
		-Dtiff-tools=OFF
		-Dwebp=OFF
		-Dzlib=ON
		-Dzstd=OFF
	)
	ps2-port_src_configure
}
