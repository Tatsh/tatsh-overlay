# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10,11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Persistent cache for aiohttp requests."
HOMEPAGE="https://github.com/requests-cache/aiohttp-client-cache"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/aiohttp-3.8[${PYTHON_USEDEP}]
	>=dev-python/attrs-21.2[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-2.0[${PYTHON_USEDEP}]
	>=dev-python/url-normalize-2.2[${PYTHON_USEDEP}]"
