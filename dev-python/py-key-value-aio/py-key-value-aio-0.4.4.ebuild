# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Key-Value Store - A pluggable interface for KV Stores."
HOMEPAGE="https://github.com/strawgate/py-key-value"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/beartype-0.20.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/aiofile-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.4.0[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.6.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/ast-comments[${PYTHON_USEDEP}]
	dev-python/dirty-equals[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/inline-snapshot[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-dotenv[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
	dev-python/testcontainers[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
