# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Plugin for Pytest to make it easy to repeat tests."
HOMEPAGE="https://pypi.org/project/pytest-repeat/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
