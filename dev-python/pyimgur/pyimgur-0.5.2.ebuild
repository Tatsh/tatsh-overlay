# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Simple Python library for anonymous use with Imgur."
HOMEPAGE="https://pypi.python.org/pypi/pyimgur"
SRC_URI="https://pypi.python.org/packages/source/p/pyimgur/pyimgur-0.5.2.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-python/requests-2.2.1"
DEPEND="${RDEPEND}"
