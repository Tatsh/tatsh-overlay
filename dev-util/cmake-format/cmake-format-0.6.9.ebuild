# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..8} )
inherit distutils-r1

DESCRIPTION="Source code formatter for CMake files."
HOMEPAGE="https://github.com/cheshirekow/cmake_format"
MY_P="${PN/-/_}-${PV}"
SRC_URI="mirror://pypi/${P:0:1}/${PN/-/_}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyyaml
	dev-python/jinja
	dev-python/six"
DEPEND="${RDEPEND}"
BDEPEND=""

S="${WORKDIR}/${MY_P}"
