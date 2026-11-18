# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-uae"
LIBRETRO_COMMIT_SHA="356160901b4563a60d663829a2e1d07a9207671c"

inherit libretro-core

DESCRIPTION="WIP libretro port of UAE (P-UAE and libco), a Commodore Amiga Emulator"
HOMEPAGE="https://github.com/libretro/libretro-uae"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
