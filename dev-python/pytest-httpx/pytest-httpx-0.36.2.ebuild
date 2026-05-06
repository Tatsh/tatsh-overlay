# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for mocking HTTPX requests"
HOMEPAGE="
	https://github.com/Colin-b/pytest_httpx
	https://pypi.org/project/pytest-httpx/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/httpx-0.28[${PYTHON_USEDEP}]
	<dev-python/httpx-0.29[${PYTHON_USEDEP}]
	>=dev-python/pytest-9[${PYTHON_USEDEP}]
	<dev-python/pytest-10[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
