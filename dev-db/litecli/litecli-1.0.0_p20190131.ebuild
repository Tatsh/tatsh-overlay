# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="CLI for SQLite Databases with auto-completion and syntax highlighting."
HOMEPAGE="https://github.com/dbcli/litecli"
MY_HASH="61d408272db7f7229f05dcaa4c54d28978000ec3"
SRC_URI="https://github.com/dbcli/litecli/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/click-4.1
	>=dev-python/pygments-2.0
	>=dev-python/prompt_toolkit-2.0.6
	<dev-python/prompt_toolkit-2.1.0
	<dev-python/python-sqlparse-0.3.0
	>=dev-python/configobj-5.0.6
	>=dev-python/cli_helpers-1.0.1"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_HASH}"
