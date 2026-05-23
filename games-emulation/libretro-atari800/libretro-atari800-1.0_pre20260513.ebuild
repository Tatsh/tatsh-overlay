# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-atari800"
LIBRETRO_COMMIT_SHA="1851228de23b47cb74fbc8ea589a1c7c5e02ea98"
inherit libretro-core

DESCRIPTION="Atari800 libretro port (Atari 8-bit / 5200)"
HOMEPAGE="https://github.com/libretro/libretro-atari800"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/zlib"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

MYEMAKEARGS=( "SYSTEM_ZLIB=1" )
