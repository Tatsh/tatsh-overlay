# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-prboom"
LIBRETRO_COMMIT_SHA="b3e5f8b2e8855f9c6fc7ff7a0036e4e61379177d"

inherit libretro libretro-core

DESCRIPTION="libretro implementation of PrBoom. (Doom)"
HOMEPAGE="https://github.com/libretro/libretro-prboom"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_install() {
	insinto "${LIBRETRO_DATA_DIR}"/prboom_libretro/
	doins "${S}"/prboom.wad
	libretro-core_src_install
}
