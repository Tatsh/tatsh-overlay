# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

DESCRIPTION="Plumb a PDF for detailed information about each text character."
HOMEPAGE="https://github.com/jsvine/pdfplumber https://pypi.org/project/pdfplumber/"
# The PyPI sdist ships the test modules but none of the PDFs they read.
SRC_URI="https://github.com/jsvine/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/pdfminer-six-20260107[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.2.0[${PYTHON_USEDEP}]
	>=dev-python/pypdfium2-bin-5.9.0[${PYTHON_USEDEP}]
"
# The conversion tests compare against DataFrames.
BDEPEND="test? ( dev-python/pandas[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}/${P}-no-coverage.patch" )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
