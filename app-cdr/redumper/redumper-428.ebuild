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
KEYWORDS=""
# Clang is forced due to ICE with GCC with -j1, failure otherwise
IUSE="+clang"
REQUIRED_CLANG_MAJOR_VERSION="18"

BDEPEND="sys-devel/clang:${REQUIRED_CLANG_MAJOR_VERSION}
	dev-build/ninja"
DEPEND=">=sys-libs/libcxx-${REQUIRED_CLANG_MAJOR_VERSION}[static-libs]
	>=sys-libs/libcxxabi-${REQUIRED_CLANG_MAJOR_VERSION}[static-libs]"

PATCHES=(
	"${FILESDIR}/${PN}-0002-missing-header.patch"
	"${FILESDIR}/${PN}-0003-no-stdlib-libcxx.patch"
)

S="${WORKDIR}/${PN}-build_${PV}"

src_configure() {
	# filter-lto
	filter-flags -O*
	if use clang; then
		append-ldflags -fuse-ld=lld # For now because it has better error messages
		CC="clang-${REQUIRED_CLANG_MAJOR_VERSION}"
		CXX="clang++-${REQUIRED_CLANG_MAJOR_VERSION}"
		export CC CXX
	fi
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -f "${D}/usr/bin/"*.pcm
}
