# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-uae"
LIBRETRO_CORE_NAME="puae2021"
LIBRETRO_COMMIT_SHA="58527ce9e8cc5f19faae9e6010d2f06fc70b10de"

inherit libretro-core

DESCRIPTION="WIP libretro port of UAE (P-UAE and libco), a Commodore Amiga Emulator."
HOMEPAGE="https://github.com/libretro/libretro-uae"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
