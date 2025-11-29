# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
DISTUTILS_EXT=1
inherit cmake distutils-r1 pypi

DESCRIPTION="A lightweight LLVM python binding for writing JIT compilers"
HOMEPAGE="https://llvmlite.readthedocs.io/en/latest/ https://pypi.org/project/llvmlite/"

LICENSE="BSD-2"
SLOT="0/0.45.0"
KEYWORDS="~amd64"

BDEPEND="llvm-core/llvm:20"
RDEPEND="${BDEPEND}"
DEPEND="${RDEPEND}"

src_prepare() {
	cd ffi || die
	cmake_src_prepare
	cd .. || die
	# Disable their use of CMake because we do the build ourselves with the eclass.
	sed -re '/build_library_files\(self\.dry_run\)/d' -i setup.py
	distutils-r1_src_prepare
}

python_configure() {
	cd ffi || die
	local mycmakeargs=(
		"-DCMAKE_PREFIX_PATH=${EPREFIX}/usr/lib/llvm/20"
		-DLLVMLITE_SKIP_LLVM_VERSION_CHECK=ON
		-DLLVMLITE_SHARED=ON
	)
	cmake_src_configure
}

python_compile() {
	export "CMAKE_PREFIX_PATH=${EPREFIX}/usr/lib/llvm/20/lib/cmake"
	cd ffi || die
	cmake_src_compile
	cd .. || die
	# Do what their ffi/build.py does.
	cp "${BUILD_DIR}/lib${PN}.so" "${PN}/binding/" || die
	distutils-r1_python_compile
}

distutils_enable_tests pytest
