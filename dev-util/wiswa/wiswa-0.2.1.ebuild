# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{1,2,3,4} )
inherit distutils-r1 pypi

DESCRIPTION="A highly opinionated way to generate and maintain projects with Jsonnet."
HOMEPAGE="https://pypi.org/project/wiswa/ https://github.com/Tatsh/wiswa"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/niquests[${PYTHON_USEDEP}]
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/bascom[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/fastmcp[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-lang/jsonnet[python,${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/niquests-cache[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
