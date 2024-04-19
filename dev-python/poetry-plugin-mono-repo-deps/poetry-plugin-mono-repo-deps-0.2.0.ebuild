# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Poetry plugin for monorepos to replace path dependencies with named dependencies."
HOMEPAGE="https://github.com/gerbenoostra/poetry-plugin-mono-repo-deps/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/poetry-core-1.7.0[${PYTHON_USEDEP}]
"

DEPEND="
	test? (
		dev-python/poetry[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
