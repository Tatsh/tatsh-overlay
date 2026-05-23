# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LIBRETRO_REPO_NAME="libretro/swanstation"
LIBRETRO_COMMIT_SHA="4d309c05fd7bdc503d91d267bd542edb8d192b09"

inherit libretro-core cmake

DESCRIPTION="Fast Sony Playstation emulator."
HOMEPAGE="https://github.com/libretro/swanstation"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

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
		LIBRETRO_LIB_DIR="/usr/$(get_libdir)/libretro"
		insinto "${LIBRETRO_LIB_DIR}"
		doins "${S}_build/${LIBRETRO_CORE_NAME}_libretro.so"
}
