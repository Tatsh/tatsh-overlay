# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin to load environment variables from a .env file"
HOMEPAGE="
	https://github.com/quiqua/pytest-dotenv
	https://pypi.org/project/pytest-dotenv/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pytest-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.9.1[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
