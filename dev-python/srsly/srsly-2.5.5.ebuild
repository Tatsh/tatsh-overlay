# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYPI_VERIFY_REPO="https://github.com/explosion/srsly"

inherit distutils-r1 pypi

DESCRIPTION="Modern high-performance serialization utilities for Python"
HOMEPAGE="https://github.com/explosion/srsly"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/catalogue-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/catalogue-2.0.3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

src_prepare() {
	# The mock backport is dead; the standard library has the same patch().
	sed -i 's/^from mock import patch$/from unittest.mock import patch/' \
		srsly/tests/test_msgpack_api.py || die
	distutils-r1_src_prepare
}

src_test() {
	# The tests are inside the package; run them from the build, which has the
	# compiled extensions, rather than the source tree's srsly/.
	mv srsly srsly.src || die
	local EPYTEST_FLAGS="--pyargs srsly"
	distutils-r1_src_test
	mv srsly.src srsly || die
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
