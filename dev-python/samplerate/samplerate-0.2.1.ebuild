# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=no
PYTHON_COMPAT=( python3_1{0,1,2} )
inherit cmake distutils-r1 pypi

DESCRIPTION="Python bindings for libsamplerate."
HOMEPAGE="https://pypi.org/project/samplerate/ https://github.com/tuxu/python-samplerate"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libsamplerate
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/pybind11[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -re 's/^(pybind11.*)/find_package(pybind11 REQUIRED)\n\1/' -i CMakeLists.txt || die
	cmake_src_prepare
	distutils-r1_python_prepare_all
}

python_configure() {
	local mycmakeargs=(
		"-DPACKAGE_VERSION_INFO=${PV}"
		"-DPYTHON_EXECUTABLE=${PYTHON}"
	)
	cmake_src_configure
}

python_compile() {
	cmake_src_compile
}

python_install() {
	python_domodule "${BUILD_DIR}/${PN}"*.so
}

distutils_enable_tests pytest
