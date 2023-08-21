# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++ FAT16 read library."
HOMEPAGE="https://github.com/Vita3K/libfat16"
SHA="14ec3073358544c70b77702ff6394f09ce349c59"
SRC_URI="https://github.com/Vita3K/libfat16/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	echo 'include(GNUInstallDirs)' > new || die
	cat CMakeLists.txt >> new || die
	mv new CMakeLists.txt
	# shellcheck disable=SC2016
	sed -re '/include\/fat16\/.*/d' \
		-e 's|target_include_directories\(.*|target_include_directories(FAT16 PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include> $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)|' \
		-i CMakeLists.txt || die
	cat >>CMakeLists.txt <<EOF
install(DIRECTORY "\${CMAKE_CURRENT_SOURCE_DIR}/include/" DESTINATION \${CMAKE_INSTALL_INCLUDEDIR})
install(TARGETS FAT16 EXPORT FAT16Config  INCLUDES DESTINATION \${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT FAT16Config DESTINATION "share/cmake/FAT16")
EOF
	cmake_src_prepare
}
