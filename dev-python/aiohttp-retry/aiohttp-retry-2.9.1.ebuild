# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1

MY_PN="${PN//-/_}"

DESCRIPTION="Retry client for aiohttp."
HOMEPAGE="https://github.com/inyutin/aiohttp_retry
	https://pypi.org/project/aiohttp-retry/"
# The sdist on PyPI omits tests/app.py and tests/__init__.py, so the test
# suite cannot import its own fixtures. The tag ships them.
SRC_URI="https://github.com/inyutin/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"

BDEPEND="test? ( dev-python/pytest-aiohttp[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
