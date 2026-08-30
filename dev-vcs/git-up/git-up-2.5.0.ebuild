# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SHA="7c7f4fca1f7b25a8dc166f62a9f9d65200f8d0b1"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/${SHA}.tar.gz
	-> ${P}-${SHA:0:8}.gh.tar.gz"
S="${WORKDIR}/PyGitUp-${SHA}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/gitpython-3.1.8[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.7[${PYTHON_USEDEP}]
	>=dev-python/termcolor-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
