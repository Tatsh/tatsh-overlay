# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1


DESCRIPTION="GRequests allows you to make syncronous HTTP requests easily"
HOMEPAGE="https://github.com/kennethreitz/grequests"
SRC_URI="https://pypi.python.org/packages/source/g/grequests/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""

RDEPEND="dev-python/gevent
>=dev-python/requests-1.0"
DEPEND="${RDEPEND}"
