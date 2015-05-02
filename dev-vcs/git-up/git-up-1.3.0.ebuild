# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="https://pypi.python.org/packages/source/g/git-up/git-up-1.3.0.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="=dev-python/GitPython-1.0.0
>=dev-python/colorama-0.3.3
>=dev-python/termcolor-1.1.0
>=dev-python/docopt-0.6.2
>=dev-python/six-1.9.0"
DEPEND="${RDEPEND}"

src_prepare () {
	epatch "${FILESDIR}/console-scripts-PyGitUp-prefix.patch"
	distutils-r1_src_prepare
}
