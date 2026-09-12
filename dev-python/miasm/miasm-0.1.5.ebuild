# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Reverse engineering framework with assembly, emulation and symbolic execution."
HOMEPAGE="https://github.com/cea-sec/miasm https://pypi.org/project/miasm/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="llvm"

RDEPEND="
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	llvm? ( dev-python/llvmlite[${PYTHON_USEDEP}] )
"

# The sdist ships only test/test_all.py, a Python 2 harness that shells out to
# test modules which are not included, so there is nothing runnable here.
RESTRICT="test"
