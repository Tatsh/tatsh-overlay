# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION="NumPy aware dynamic Python compiler using LLVM"
HOMEPAGE="https://pypi.org/project/numba/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="dev-python/llvmlite[${PYTHON_USEDEP}]
	dev-python/setuptools:0[${PYTHON_USEDEP}]
	${BDEPEND}"

distutils_enable_tests pytest
