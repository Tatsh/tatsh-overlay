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

RDEPEND=">=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/fastmcp-3.2.4[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.6[${PYTHON_USEDEP}]
	>=dev-lang/jsonnet-0.22.0[python,${PYTHON_USEDEP}]
	>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.6[${PYTHON_USEDEP}]
	>=dev-python/niquests-cache-0.0.3[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/python-gitlab-8.2.0[${PYTHON_USEDEP}]
	>=dev-python/rich-15.0.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
