# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{11,12,13,14,15} )

PYPI_VERIFY_REPO="https://github.com/mosquito/caio"

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous file IO for Linux MacOS or Windows."
HOMEPAGE="https://github.com/mosquito/caio"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	rm -fR tests
	distutils-r1_src_prepare
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
