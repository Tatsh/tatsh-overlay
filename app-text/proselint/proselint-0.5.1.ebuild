# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

inherit distutils-r1

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="http://proselint.com/"
SRC_URI="https://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-python/click-6.3
>=dev-python/future-0.15.2
>=dev-python/six-1.9.0"
DEPEND="${RDEPEND}"

src_prepare() {
	# find_packages() will find 'tests'
	sed '17s/find_packages()/[x for x in find_packages() if x != "tests"]/' -i setup.py
	sed "206s:'r+',:'r',:" -i proselint/command_line.py
}
