# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="The Blis BLAS-like linear algebra library, as a self-contained C-extension."
HOMEPAGE="https://github.com/explosion/cython-blis"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/numpy-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

src_compile() {
	export BLIS_ARCH="generic"
	distutils-r1_src_compile
}
