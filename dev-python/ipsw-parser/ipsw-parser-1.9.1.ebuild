# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/doronz88/ipsw_parser
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Utility for parsing and extracting data from IPSW files"
HOMEPAGE="https://github.com/doronz88/ipsw_parser https://pypi.org/project/ipsw-parser/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/ansilogs-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/bytestruct-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	dev-python/remotezip2[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typer[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
