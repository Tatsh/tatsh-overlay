# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

PYPI_VERIFY_REPO="https://github.com/explosion/cymem"

inherit distutils-r1 pypi

DESCRIPTION="Manage calls to calloc/free through Cython"
HOMEPAGE="https://github.com/explosion/cymem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_test() {
	# Import the built extensions rather than the source-tree package, which holds the tests.
	mv "${PN}/tests" tests || die
	rm -r "${PN}" || die
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
