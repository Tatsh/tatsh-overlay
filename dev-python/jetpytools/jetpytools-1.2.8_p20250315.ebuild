# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1

DESCRIPTION="Collection of stuff that's useful in general Python programming."
HOMEPAGE="https://pypi.org/project/jetpytools/"
SHA="691f91bda865ebc1eda92758908d538c1a6e15c8"
SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${SHA}"
