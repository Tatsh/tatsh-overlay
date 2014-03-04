# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="A content management platform built using the Django framework."
HOMEPAGE="http://mezzanine.jupo.org/"
SRC_URI="http://pypi.python.org/packages/source/M/Mezzanine/Mezzanine-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="twitter"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/future-0.11.3
	>=dev-python/bleach-1.4
	>=dev-python/filebrowser-safe-0.3.2
	>=dev-python/grappelli-safe-0.3.6
	twitter? ( >=dev-python/requests-oauthlib-0.3.3 )
"

S="${WORKDIR}/Mezzanine-${PV}"
