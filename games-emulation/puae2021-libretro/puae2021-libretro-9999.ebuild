# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/libretro-uae"
LIBRETRO_CORE_NAME="puae2021"

inherit libretro-core

EGIT_BRANCH="2.6.1"

DESCRIPTION="WIP libretro port of UAE (P-UAE and libco), a Commodore Amiga Emulator."
HOMEPAGE="https://github.com/libretro/libretro-uae"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
