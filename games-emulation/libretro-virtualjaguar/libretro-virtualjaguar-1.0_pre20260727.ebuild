# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/virtualjaguar-libretro"
LIBRETRO_COMMIT_SHA="cab0671a6741876f92f0873e201f15550e5a0995"
inherit libretro-core

DESCRIPTION="Virtual Jaguar libretro port (Atari Jaguar)"
HOMEPAGE="https://github.com/libretro/virtualjaguar-libretro"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
