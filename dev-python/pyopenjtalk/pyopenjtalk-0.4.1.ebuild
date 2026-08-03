# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

PYPI_VERIFY_REPO="https://github.com/r9y9/pyopenjtalk"

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for OpenJTalk."
HOMEPAGE="https://github.com/r9y9/pyopenjtalk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/numpy-1.20.0[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	test? ( dev-python/scipy[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
