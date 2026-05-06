# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous file operations."
HOMEPAGE="https://github.com/mosquito/aiofile"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/caio-0.9.0[${PYTHON_USEDEP}]
	<dev-python/caio-0.10.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/aiomisc-pytest[${PYTHON_USEDEP}]
	dev-python/markdown-pytest[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
