# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{4..7} )
inherit distutils-r1

DESCRIPTION="Source code formatter for CMake files."
HOMEPAGE="https://github.com/cheshirekow/cmake_format"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyyaml
	dev-python/jinja"
DEPEND="${RDEPEND}"
BDEPEND=""
