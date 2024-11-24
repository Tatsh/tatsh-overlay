# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SHA="eb7b155e3396ac645dc075665e87b16bc34e6827"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/${SHA}.tar.gz -> ${P}.tar.gz"
IUSE="test"
RESTRICT="!test? ( test )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-python/gitpython-3.1.8
	>=dev-python/colorama-0.3.7
	>=dev-python/termcolor-2.0.0
	>=dev-python/six-1.10.0
	>=dev-python/click-8.0.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyGitUp-${SHA}"
