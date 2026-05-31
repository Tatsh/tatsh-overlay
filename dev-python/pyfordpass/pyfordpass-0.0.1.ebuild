# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="FordPass client and CLI"
HOMEPAGE="
	https://tatsh.github.io/pyfordpass/
	https://github.com/Tatsh/pyfordpass
	https://pypi.org/project/pyfordpass/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/bascom-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/click-8.4.1[${PYTHON_USEDEP}]
	>=dev-python/curl-cffi-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.8[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/rich-15.0.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
