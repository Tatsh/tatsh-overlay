# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous client for the reverse engineered Shazam API"
HOMEPAGE="https://github.com/shazamio/ShazamIO https://pypi.org/project/shazamio/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-retry-2.3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.2.0[${PYTHON_USEDEP}]
	~dev-python/shazamio-core-2.0.0[${PYTHON_USEDEP}]
"
