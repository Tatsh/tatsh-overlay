# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="ImgurShare"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The simple way of using Imgur."
HOMEPAGE="https://github.com/Tatsh/imgur-share"
SRC_URI="https://pypi.python.org/packages/source/I/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-python/pyimgur-0.5.2"
RDEPEND="${DEPEND}"
