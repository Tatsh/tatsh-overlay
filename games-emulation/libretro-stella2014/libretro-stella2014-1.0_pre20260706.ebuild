# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/stella2014-libretro"
LIBRETRO_COMMIT_SHA="4a7da82595d27b8df7af1ecb467a64b642a41bc9"
inherit libretro-core

DESCRIPTION="Stella 2014 libretro port (Atari 2600 VCS)"
HOMEPAGE="https://github.com/libretro/stella2014-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
