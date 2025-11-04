# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/vice-libretro"
LIBRETRO_COMMIT_SHA="e9f8ac034ddef3025f0567768f7af8219f7cfdb8"

inherit libretro-core

DESCRIPTION="Versatile Commodore 8-bit Emulator as a libretro core"
HOMEPAGE="https://github.com/libretro/vice-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_compile() {
	# Extracting the EMUTYPE from PN (e.g. vice-x64-libretro -> x64)
	EMUTYPE=${PN#vice-}
	EMUTYPE=${EMUTYPE%-libretro}
	MYEMAKEARGS=(
		EMUTYPE="${EMUTYPE}"
	)
	libretro-core_src_compile
}
