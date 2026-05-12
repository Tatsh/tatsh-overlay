# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="C++ frame profiler"
HOMEPAGE="https://github.com/wolfpld/tracy"
SRC_URI="https://github.com/wolfpld/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/capstone
	media-libs/freetype
	media-libs/glfw"
RDEPEND="${DEPEND}"

src_prepare() {
	# Upstream appends $<CONFIG> to the lib install destination for
	# non-Release builds, which lands the library in /usr/lib64/RelWithDebInfo/
	# under Gentoo's default CMAKE_BUILD_TYPE.
	sed -re 's|/\$<IF:\$<CONFIG:Release>,,\$<CONFIG>>||g' -i CMakeLists.txt || die
	cmake_src_prepare
}
