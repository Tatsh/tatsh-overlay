# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SHA="3e967c5b17c8bc4081b4c01269cf3f91cdde9c9f"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/${SHA}.tar.gz -> ${P}.tar.gz"
IUSE="test"
RESTRICT="!test? ( test )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-python/GitPython-3.1.8
	>=dev-python/colorama-0.3.7
	>=dev-python/termcolor-2.0.0
	>=dev-python/six-1.10.0
	>=dev-python/click-8.0.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyGitUp-${SHA}"
