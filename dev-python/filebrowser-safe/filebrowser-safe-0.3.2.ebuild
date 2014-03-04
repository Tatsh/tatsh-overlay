# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1

MY_PN="filebrowser_safe"

DESCRIPTION="A snapshot of the filebrowser_3 branch of django-filebrowser, packaged as a dependency for the Mezzanine CMS for Django."
HOMEPAGE="https://pypi.python.org/pypi/filebrowser_safe"
SRC_URI="https://pypi.python.org/packages/source/f/filebrowser_safe/filebrowser_safe-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"
