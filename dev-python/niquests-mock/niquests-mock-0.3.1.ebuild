# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="RESPX-like HTTP mocking for niquests"
HOMEPAGE="
	https://github.com/0x12th/niquests-mock
	https://pypi.org/project/niquests-mock/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/niquests-3.17.0[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.10.18[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
