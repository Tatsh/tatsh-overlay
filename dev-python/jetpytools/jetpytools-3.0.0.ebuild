# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Collection of stuff that's useful in general Python programming."
HOMEPAGE="https://pypi.org/project/jetpytools/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
