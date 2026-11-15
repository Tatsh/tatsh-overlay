# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Static memory-efficient and fast Trie-like structures for Python"
HOMEPAGE="https://github.com/pytries/marisa-trie https://pypi.org/project/marisa-trie/"

# The bundled marisa C++ library is built in: its API differs from the
# dev-libs/marisa release in ::gentoo (exception.h, scoped-ptr.h and changed
# trie/keyset headers), so the extension does not build against that.
LICENSE="MIT || ( BSD-2 LGPL-2.1+ )"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-python/cython-3.1.3[${PYTHON_USEDEP}]
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

EPYTEST_IGNORE=(
	# Checks the README renders on PyPI.
	tests/test_packaging.py
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
