# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )
inherit distutils-r1 pypi

DESCRIPTION="Tool to download data from Patreon."
HOMEPAGE="
	https://github.com/Tatsh/patreon-archiver
	https://pypi.org/project/patreon-archiver/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.4[${PYTHON_USEDEP}]
	>=dev-python/rich-14.3.3[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/yt-dlp-utils-0.0.8[${PYTHON_USEDEP}]"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
