# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The module relocation config optimization tool."
HOMEPAGE="https://github.com/Princess-of-Sleeping/psp2rela"
SHA="9e0f4913866431aef48967cfb7667b085e79428b"
SRC_URI="https://github.com/Princess-of-Sleeping/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -re 's/find_package\(zlib.*//' -e 's/\$\{zlib_LIBRARIES\}/z/' -i CMakeLists.txt || die
	cmake_src_prepare
}
