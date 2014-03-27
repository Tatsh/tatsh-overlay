# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{2,3} pypy2_0 )

inherit distutils-r1

MY_P="HttpExt"
S="${WORKDIR}/${MY_P}-${PV}"

DESCRIPTION="Helpers for downloading files."
HOMEPAGE="http://pypi.python.org/pypi/HttpExt/"
SRC_URI="https://pypi.python.org/packages/source/H/${MY_P}/${MY_P}-${PV}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""
