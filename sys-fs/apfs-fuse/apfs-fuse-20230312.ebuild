# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Read-only FUSE driver for the Apple File System (APFS)"
HOMEPAGE="https://github.com/sgan81/apfs-fuse"
SHA="66b86bd525e8cb90f9012543be89b1f092b75cf3"
LZFSE_SHA="e634ca58b4821d9f3d560cdc6df5dec02ffc93fd"
SRC_URI="https://github.com/sgan81/apfs-fuse/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/lzfse/lzfse/archive/${LZFSE_SHA}.tar.gz -> lzfse-${LZFSE_SHA:0:7}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"

# lzfse is bundled because apfs-fuse uses its internal lzvn decoder API.
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/bzip2:=
	sys-fs/fuse:3=
	virtual/zlib:="
RDEPEND="${DEPEND}"

src_prepare() {
	rmdir 3rdparty/lzfse || die
	mv "${WORKDIR}/lzfse-${LZFSE_SHA}" 3rdparty/lzfse || die
	# Sources are compiled directly by the top-level CMakeLists.txt
	rm 3rdparty/lzfse/CMakeLists.txt || die
	sed -i '1i #include <cstdint>' ApfsLib/PList.h || die
	sed -e '/^cmake_minimum_required/s/3\.0/3.10/' \
		-e '/^set(CMAKE_BUILD_TYPE/d' \
		-i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	# Internal libraries are not installed
	local mycmakeargs=( -DBUILD_SHARED_LIBS=OFF )
	cmake_src_configure
}
