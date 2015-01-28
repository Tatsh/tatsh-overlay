# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{2,3} )

inherit distutils-r1

MY_PN="OSExtension"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Extension for os module, for POSIX systems only"
HOMEPAGE="http://pypi.python.org/pypi/OSExtension/"
SRC_URI="https://pypi.python.org/packages/source/O/OSExtension/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND="${DEPEND}"
