# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 flag-o-matic pypi

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://pypi.org/project/numba/"
IUSE="tbb"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="tbb? ( dev-cpp/tbb )
	dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="dev-python/llvmlite[${PYTHON_USEDEP}]
	dev-python/setuptools:0[${PYTHON_USEDEP}]"

src_configure() {
	append-ldflags "$(no-as-needed)"
	distutils-r1_src_configure
}

src_compile() {
	export MAKEOPTS=-j1
	! use tbb && export NUMBA_DISABLE_TBB=1
	distutils-r1_src_compile
}

distutils_enable_tests pytest
