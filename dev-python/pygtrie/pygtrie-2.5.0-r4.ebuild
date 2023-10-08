# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )
inherit distutils-r1 pypi

DESCRIPTION="A pure Python trie data structure implementation."
HOMEPAGE="https://pypi.org/project/pygtrie/ https://github.com/mina86/pygtrie"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
