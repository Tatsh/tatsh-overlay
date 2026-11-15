# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Low level CD dumper utility"
HOMEPAGE="https://github.com/superg/redumper"
SRC_URI="https://github.com/superg/redumper/archive/refs/tags/b${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-b${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# Clang is forced due to ICE with GCC with -j1, failure otherwise
IUSE="+clang test"
RESTRICT="!test? ( test )"

BDEPEND=">=llvm-core/clang-16.0.6
	dev-build/ninja"
DEPEND=">=llvm-runtimes/libcxx-16[static-libs]
	>=llvm-runtimes/libcxxabi-16[static-libs]
	test? ( dev-cpp/gtest )"

src_prepare() {
	if ! use test; then
		sed -re '/^enable_testing.*/d' -e 's/^add_subdirectory\(.tests.\)$//' -i CMakeLists.txt || die
	fi
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# b751 added clang-tidy targets that read BUILDSYSTEM_TARGETS out of
		# tests/gtest, which src_prepare drops without USE=test; configure dies
		# on it then. These are lint targets only.
		-DCLANG_TIDY=OFF
		# tests/CMakeLists.txt declares googletest with FIND_PACKAGE_ARGS; never fetch it.
		-DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS
	)
	filter-flags -O*
	if use clang; then
		CC=clang
		CXX=clang++
		export CC CXX
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -f "${D}/usr/bin/"*.pcm
}
