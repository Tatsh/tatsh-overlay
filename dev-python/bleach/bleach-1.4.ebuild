# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{2,3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="An easy, HTML5, whitelisting HTML sanitizer."
HOMEPAGE="https://pypi.python.org/pypi/bleach"
SRC_URI="https://pypi.python.org/packages/source/b/bleach/bleach-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/six
	>=dev-python/html5lib-0.999
"
