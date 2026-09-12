# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous client for the reverse engineered Shazam API."
HOMEPAGE="https://github.com/shazamio/ShazamIO
	https://pypi.org/project/shazamio/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiofiles-23.2.1[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.8.3[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-retry-2.8.3[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.3.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.2.2[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9.2[${PYTHON_USEDEP}]
	>=dev-python/pydub-0.25.1[${PYTHON_USEDEP}]
	=dev-python/shazamio-core-1.1.2[${PYTHON_USEDEP}]
	<dev-python/dataclass-factory-3.0[${PYTHON_USEDEP}]
	>=dev-python/dataclass-factory-2.16[${PYTHON_USEDEP}]
"
