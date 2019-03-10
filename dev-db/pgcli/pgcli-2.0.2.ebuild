# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="Command line interface for Postgres with auto-completion and syntax highlighting."
HOMEPAGE="https://www.pgcli.com/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND} >=dev-python/setproctitle-1.1.9
	>=dev-python/click-4.1
	>=dev-python/pgspecial-1.11.5
	>=dev-python/pygments-2.0
	>=dev-python/prompt_toolkit-2.0.6
	<dev-python/prompt_toolkit-2.1.0
	<dev-python/psycopg-2.8
	<dev-python/python-sqlparse-0.3.0
	>=dev-python/configobj-5.0.6
	>=dev-python/humanize-0.5.1
	>=dev-python/cli_helpers-1.0.1"
DEPEND="${RDEPEND}"
BDEPEND=""
