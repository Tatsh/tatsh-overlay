# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR=ninja # required for C++ modules
inherit cmake flag-o-matic

DESCRIPTION="Low level CD dumper utility"
HOMEPAGE="https://github.com/superg/redumper"
SRC_URI="https://github.com/superg/redumper/archive/refs/tags/b${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-b${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
# Clang is forced due to ICE with GCC with -j1, failure otherwise
IUSE="+clang"

BDEPEND=">=llvm-core/clang-16.0.6
	dev-build/ninja"
DEPEND=">=llvm-runtimes/libcxx-16[static-libs]
	>=llvm-runtimes/libcxxabi-16[static-libs]"

src_configure() {
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
