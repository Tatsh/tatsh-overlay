# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

MY_PN="pdfminer.six"

DESCRIPTION="Tool for extracting information from PDF documents."
HOMEPAGE="https://github.com/pdfminer/pdfminer.six https://pypi.org/project/pdfminer.six/"
# The PyPI sdist omits samples/, which 90 of the tests read.
SRC_URI="https://github.com/pdfminer/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/charset-normalizer-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-36.0.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

# Upstream takes the version from git, which the archive has no trace of.
export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
