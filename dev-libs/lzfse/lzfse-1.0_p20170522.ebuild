# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

# Two documentation-only commits past the lzfse-1.0 tag, which is the last
# release upstream made.
MY_COMMIT="e634ca58b4821d9f3d560cdc6df5dec02ffc93fd"

DESCRIPTION="LZFSE compression library and command line tool."
HOMEPAGE="https://github.com/lzfse/lzfse"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	# CMake 4 refuses a minimum below 3.5. Do this before cmake_src_prepare,
	# which is where the eclass scans for the old minimum.
	sed -i -e 's/cmake_minimum_required(VERSION 2.8.6)/cmake_minimum_required(VERSION 3.10)/' \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DLZFSE_DISABLE_TESTS=$(usex test OFF ON)
	)

	cmake_src_configure
}
