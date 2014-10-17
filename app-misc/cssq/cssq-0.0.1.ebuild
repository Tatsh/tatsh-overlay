# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{3,4} )

inherit distutils-r1

MY_PN="cssq"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Filter HTML with a CSS query"
HOMEPAGE="https://github.com/Tatsh/cssq"
SRC_URI="https://pypi.python.org/packages/source/c/cssq/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-python/beautifulsoup-4.3.2
	>=dev-python/requests-2.4.1
	>=dev-python/html5lib-0.999
"
