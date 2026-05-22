# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="FastMCP server exposing Wiswa settings discovery for AI assistants."
HOMEPAGE="
	https://tatsh.github.io/wiswa-mcp/
	https://github.com/Tatsh/wiswa-mcp
	https://pypi.org/project/wiswa-mcp/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/bascom-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/fastmcp-3.2.4[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.8[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-util/wiswa-0.4.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
