# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async OAuth client using HTTPX"
HOMEPAGE="
	https://github.com/frankie567/httpx-oauth
	https://pypi.org/project/httpx-oauth/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/httpx-0.18[${PYTHON_USEDEP}]"
BDEPEND="dev-python/hatch-regex-commit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
