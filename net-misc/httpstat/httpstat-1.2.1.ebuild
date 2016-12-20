# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1

MY_PN="httpstat"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="cURL statistics made simple."
HOMEPAGE="https://github.com/reorx/httpstat"
SRC_URI="https://github.com/reorx/${MY_PN}/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
