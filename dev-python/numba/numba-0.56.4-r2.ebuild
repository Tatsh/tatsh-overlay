# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
inherit distutils-r1 flag-o-matic

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://pypi.org/project/numba/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
IUSE="tbb"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="<dev-python/numpy-1.24.0[${PYTHON_USEDEP}]"
DEPEND="tbb? ( <dev-cpp/tbb-2021.5.0-r1 )"
RDEPEND="dev-python/llvmlite[${PYTHON_USEDEP}]
	dev-python/setuptools:0[${PYTHON_USEDEP}]
	${BDEPEND}"

src_configure() {
	append-ldflags $(no-as-needed)
	distutils-r1_src_configure
}

src_compile() {
	export MAKEOPTS=-j1
	! use tbb && export NUMBA_DISABLE_TBB=1
	distutils-r1_src_compile
}

distutils_enable_tests pytest
