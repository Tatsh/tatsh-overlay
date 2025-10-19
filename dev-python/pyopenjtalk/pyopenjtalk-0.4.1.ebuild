# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Python wrapper for OpenJTalk."
HOMEPAGE="https://github.com/r9y9/pyopenjtalk"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"
