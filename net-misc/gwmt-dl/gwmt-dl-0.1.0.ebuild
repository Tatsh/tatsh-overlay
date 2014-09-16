# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN="gwmt-dl"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Downloads Google WebMaster search queries and top pages data as CSV data."
HOMEPAGE="https://github.com/Tatsh/gwmt-dl"
SRC_URI="https://pypi.python.org/packages/source/g/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-python/gdata-2.0.14"
RDEPEND="${DEPEND}"
