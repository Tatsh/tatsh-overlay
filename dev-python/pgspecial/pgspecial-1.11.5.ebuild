# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="Meta-commands handler for Postgres Database."
HOMEPAGE="https://www.dbcli.com/ https://github.com/dbcli/pgspecial"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/click-4.1
	>=dev-python/python-sqlparse-0.1.19
	<dev-python/psycopg-2.8"
DEPEND="${RDEPEND}"
BDEPEND=""
