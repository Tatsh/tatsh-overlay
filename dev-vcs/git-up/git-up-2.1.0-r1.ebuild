# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..10} )
inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
IUSE="test"
RESTRICT="!test? ( test )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-python/GitPython-3.1.8
	>=dev-python/colorama-0.3.7
	<dev-python/termcolor-2.0.0
	>=dev-python/six-1.10.0
	>=dev-python/click-8.0.1"
DEPEND="${RDEPEND}"
