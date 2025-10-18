# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Cython MeCab wrapper for fast, pythonic Japanese tokenization."
HOMEPAGE="https://github.com/polm/fugashi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-text/mecab"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"
