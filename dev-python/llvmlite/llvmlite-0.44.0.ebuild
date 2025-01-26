# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="A lightweight LLVM python binding for writing JIT compilers"
HOMEPAGE="https://llvmlite.readthedocs.io/en/latest/ https://pypi.org/project/llvmlite/"

LICENSE="BSD-2"
SLOT="0/0.44.0"
KEYWORDS="~amd64"

BDEPEND="llvm-core/llvm:15"
RDEPEND="${BDEPEND}"
DEPEND="${RDEPEND}"

python_compile() {
	export "LLVM_CONFIG=${EPREFIX}/usr/lib/llvm/15/bin/llvm-config"
	distutils-r1_python_compile
}

distutils_enable_tests pytest
