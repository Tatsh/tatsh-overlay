# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1

DESCRIPTION="Collection of stuff that's useful in general Python programming."
HOMEPAGE="https://pypi.org/project/${PN}/"
SHA="8ee84a47ec605695ab2e765518b3b743907bed74"
SRC_URI="https://github.com/Setsugennoao/stgpytools/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${SHA}"
