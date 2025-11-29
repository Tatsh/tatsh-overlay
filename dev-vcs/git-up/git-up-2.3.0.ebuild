# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry

PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SHA="ae06420e2833f6b1c91473bd2756ea8ed296b3d1"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/${SHA}.tar.gz -> ${P}.tar.gz"
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
