# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp"
MY_HASH="448d31edefac4ab53965f207e8f1feea4f1f88e3"
SRC_URI="https://github.com/msiemens/PyGitUp/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/gitpython-2.1.1
>=dev-python/colorama-0.3.7
>=dev-python/termcolor-1.1.0
>=dev-python/click-6.0.0
>=dev-python/six-1.10.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}/PyGitUp-${MY_HASH}"
