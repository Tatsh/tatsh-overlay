# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Vector command line preprocessor for PlayStation 2 VU microcode"
HOMEPAGE="https://github.com/ps2dev/openvcl"
SRC_URI="https://github.com/ps2dev/openvcl/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AFL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	sed -i -e '/^\s*-Werror$/d' CMakeLists.txt || die
	# The version header is generated in the build directory.
	sed -i -e 's|"../../src/OpenVclVersion.h"|"OpenVclVersion.h"|' test/integration/test_cli.cpp || die
	# shellcheck disable=SC2016
	sed -i -e '/^target_include_directories(openvcl_unit_tests PRIVATE/a\    ${CMAKE_BINARY_DIR}' \
		test/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( "-DBUILD_TESTING=$(usex test)" )
	cmake_src_configure
}
