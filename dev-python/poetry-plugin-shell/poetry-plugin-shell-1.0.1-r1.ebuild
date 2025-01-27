# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Runs a subshell with virtual environment activated."
HOMEPAGE="https://github.com/python-poetry/poetry-plugin-shell"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/poetry-2.0.0[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
"

DEPEND="
	test? (
		dev-python/poetry[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
