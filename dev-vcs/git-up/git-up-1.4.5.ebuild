# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/v${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}/PyGitUp-${PV}"

RDEPEND=">=dev-python/GitPython-2.1.1
>=dev-python/colorama-0.3.7
>=dev-python/termcolor-1.1.0
>=dev-python/click-6.0.0
>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}"
