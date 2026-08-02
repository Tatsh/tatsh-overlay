# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/vice-libretro"
LIBRETRO_COMMIT_SHA="c8c242db75a559246d6d51017e6dd4ecd75d6a9f"

inherit libretro-core

DESCRIPTION="Versatile Commodore 8-bit Emulator as a libretro core"
HOMEPAGE="https://github.com/libretro/vice-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_compile() {
	# Extracting the EMUTYPE from PN (e.g. libretro-vice-x64sc -> x64sc)
	local emutype=${PN#libretro-vice-}
	MYEMAKEARGS=(
		EMUTYPE="${emutype}"
	)
	libretro-core_src_compile
}
