# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Emulator, assembler, etc for XpertTeak, the DSP used by DSi/3DS."
HOMEPAGE="https://github.com/wwylele/teakra"
SHA="d4bea3ec3acd5ea9cc23f096ed0af4de1c002201"
SRC_URI="https://github.com/wwylele/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		-DTEAKRA_BUILD_TOOLS=OFF
		-DTEAKRA_BUILD_UNIT_TESTS=OFF
	)
	cmake_src_configure
}

src_install() {
	einstalldocs
	dolib.so "${BUILD_DIR}/src/lib${PN}.so" "${BUILD_DIR}/src/lib${PN}_c.so"
	insinto /usr/include
	doins -r include/${PN}
}
