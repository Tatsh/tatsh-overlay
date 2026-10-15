# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Macro assembler preprocessor for PlayStation 2 VU code (based on GNU gasp)"
HOMEPAGE="https://github.com/ps2dev/masp"
SRC_URI="https://github.com/ps2dev/masp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

src_prepare() {
	sed -i -e '/target_compile_options(masp PRIVATE -Werror)/d' src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( "-DBUILD_TESTING=$(usex test)" )
	cmake_src_configure
}
