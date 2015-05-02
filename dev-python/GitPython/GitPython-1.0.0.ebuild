# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{3,4} )

inherit distutils-r1

DESCRIPTION="Library to interact with Git repositories."
HOMEPAGE="https://gitpython.readthedocs.org/en/stable/"
SRC_URI="https://pypi.python.org/packages/source/G/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/gitdb-0.6.2"
DEPEND="${RDEPEND}"
