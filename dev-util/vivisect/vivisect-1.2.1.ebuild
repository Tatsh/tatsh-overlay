# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )
inherit distutils-r1 pypi

DESCRIPTION="A combined disassembler/static analysis/symbolic execution/debugger framework."
HOMEPAGE="https://github.com/vivisect/vivisect"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	>=dev-python/cxxfilt-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/msgpack-1.0.8[${PYTHON_USEDEP}]
	>=dev-python/pycparser-2.22[${PYTHON_USEDEP}]
	>=dev-python/pyqt5-5.15.7[${PYTHON_USEDEP}]
	>=dev-python/pyqtwebengine-5.15.6[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
