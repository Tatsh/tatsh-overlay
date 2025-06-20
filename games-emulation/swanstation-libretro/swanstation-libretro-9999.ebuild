# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/swanstation"

inherit libretro-core cmake

DESCRIPTION="Fast Sony Playstation emulator."
HOMEPAGE="https://github.com/libretro/swanstation"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

DEPEND="
		media-libs/vulkan-loader
"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_configure() {
		local mycmakeargs=(
			-DBUILD_LIBRETRO_CORE=ON
			-DBUILD_QT_FRONTEND=OFF
			-DENABLE_DISCORD_PRESENCE=OFF
			-DCMAKE_BUILD_TYPE=Release
			-DENABLE_CHEEVOS=ON
			-DBUILD_SHARED_LIBS=OFF
		)
		cmake_src_configure
}

src_install() {
		LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"
		libretro-core_src_install
}
