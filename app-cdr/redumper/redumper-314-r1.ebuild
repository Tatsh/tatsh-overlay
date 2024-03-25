# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=ninja # required for C++ modules
inherit cmake flag-o-matic

DESCRIPTION="Low level CD dumper utility"
HOMEPAGE="https://github.com/superg/redumper"
SRC_URI="https://github.com/superg/redumper/archive/refs/tags/build_${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=sys-devel/clang-16.0.6
	dev-build/ninja"
DEPEND=">=sys-libs/libcxx-16[static-libs]
	>=sys-libs/libcxxabi-16[static-libs]"

S="${WORKDIR}/${PN}-build_${PV}"
# Necessary to avoid expansion in mycmakeargs below, even with single quotes
# shellcheck disable=SC3146,SC2016
QUOTED_DOLLAR_SCAN_DEPS='${CMAKE_CXX_COMPILER_CLANG_SCAN_DEPS}'

src_configure() {
	filter-flags -O*
	CC=$(command -v clang-18 || command -v clang-17 || command -v clang-16)
	CXX=$(command -v clang++-18 || command -v clang++-17 || command -v clang++-16)
	export CC CXX
	append-cxxflags -Wno-unknown-warning-option -fexperimental-library
	local mycmakeargs=(
		"-DCMAKE_EXPERIMENTAL_CXX_SCANDEP_SOURCE=${QUOTED_DOLLAR_SCAN_DEPS} -format=p1709 -- <CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -x c++ <SOURCE> -c -o <OBJECT> -MT <DYNDEP_FILE> > <DYNDEP_FILE>"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -f "${D}/usr/bin/"*.pcm
}
