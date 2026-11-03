# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LIBRETRO_REPO_NAME="libretro/vice-libretro"
LIBRETRO_COMMIT_SHA="5ebe7d333ab15be57a9dde5f46c29a5bbd5f44f8"

inherit libretro-core

DESCRIPTION="Versatile Commodore 8-bit Emulator as a libretro core"
HOMEPAGE="https://github.com/libretro/vice-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_compile() {
	# Extracting the EMUTYPE from PN (e.g. libretro-vice-x64 -> x64)
	local emutype=${PN#libretro-vice-}
	MYEMAKEARGS=(
		EMUTYPE="${emutype}"
	)
	libretro-core_src_compile
}
