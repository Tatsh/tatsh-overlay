# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/prosystem-libretro"
LIBRETRO_COMMIT_SHA="363b6dfbd3e240762e022c2b4897b4fe55722be3"
inherit libretro-core

DESCRIPTION="ProSystem libretro port (Atari 7800)"
HOMEPAGE="https://github.com/libretro/prosystem-libretro"
LICENSE="GPL-2+ ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
