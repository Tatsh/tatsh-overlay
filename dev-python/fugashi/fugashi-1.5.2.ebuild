# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Cython MeCab wrapper for fast, pythonic Japanese tokenization"
HOMEPAGE="https://github.com/polm/fugashi"

# The tests need a UniDic; unidic-lite ships one in its sdist.
SRC_URI+=" test? ( $(pypi_sdist_url --no-normalize unidic-lite 1.0.8) )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-text/mecab"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

EPYTEST_IGNORE=(
	# Needs the ipadic Python package, which is not packaged.
	tests/test_ipadic.py
)

src_test() {
	# Import the built extension rather than the source-tree package, which holds the tests.
	mv "${PN}/tests" tests || die
	rm -r "${PN}" || die
	# Tagger() prefers the unidic module if one is installed; point it at
	# unidic-lite's dictionary so the tests use the one fetched for them.
	mkdir -p "${T}/unidic-shim/unidic" || die
	echo 'from unidic_lite import DICDIR' > "${T}/unidic-shim/unidic/__init__.py" || die
	local -x PYTHONPATH="${T}/unidic-shim:${WORKDIR}/unidic-lite-1.0.8${PYTHONPATH:+:${PYTHONPATH}}"
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
