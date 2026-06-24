# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Intuitive, easy CLIs based on type hints."
HOMEPAGE="https://github.com/BrianPugh/cyclopts"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/attrs-23.1.0[${PYTHON_USEDEP}]
	>=dev-python/docstring-parser-0.15[${PYTHON_USEDEP}]
	<dev-python/docstring-parser-4.0[${PYTHON_USEDEP}]
	>=dev-python/rich-rst-1.3.1[${PYTHON_USEDEP}]
	<dev-python/rich-rst-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.6.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/syrupy[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/trio[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
