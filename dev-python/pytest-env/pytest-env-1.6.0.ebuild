# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin to set environment variables for tests"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-env
	https://pypi.org/project/pytest-env/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pytest-9.0.2[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.2.2[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
