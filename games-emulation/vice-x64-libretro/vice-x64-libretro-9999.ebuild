# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/vice-libretro"
inherit libretro-core

DESCRIPTION="Versatile Commodore 8-bit Emulator as a libretro core"
HOMEPAGE="https://github.com/libretro/vice-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_compile() {
	# Extracting the EMUTYPE from PN (e.g. vice-x64-libretro -> x64)
	EMUTYPE=${PN#vice-}
	EMUTYPE=${EMUTYPE%-libretro}
	myemakeargs=(
		EMUTYPE=${EMUTYPE}
	)
	libretro-core_src_compile
}
