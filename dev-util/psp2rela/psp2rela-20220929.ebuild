# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="The module relocation config optimization tool."
HOMEPAGE="https://github.com/Princess-of-Sleeping/psp2rela"
SHA="09361094cbf598444a1767d09357f57f54cc646c"
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
