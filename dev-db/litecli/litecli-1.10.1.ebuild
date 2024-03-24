# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="CLI for SQLite Databases with auto-completion and syntax highlighting."
HOMEPAGE="https://github.com/dbcli/litecli"
SRC_URI="https://github.com/dbcli/litecli/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/click-4.1
	>=dev-python/pygments-2.0
	>=dev-python/prompt-toolkit-3.0.3
	<dev-python/prompt-toolkit-4.0.0
	dev-python/sqlparse
	>=dev-python/configobj-5.0.6
	>=dev-python/cli-helpers-1.0.1"
