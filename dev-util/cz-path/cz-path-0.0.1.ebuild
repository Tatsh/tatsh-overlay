# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1 pypi

DESCRIPTION="Commitizen plugin that prefixes commit messages with the common path or prefix of staged files."
HOMEPAGE="https://pypi.org/project/cz-path/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/gitpython[${PYTHON_USEDEP}]
	dev-util/commitizen[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
