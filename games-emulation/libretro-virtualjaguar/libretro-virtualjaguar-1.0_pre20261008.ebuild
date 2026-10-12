# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/virtualjaguar-libretro"
LIBRETRO_COMMIT_SHA="03ced5f903641083f2d819b07252344176f47b7f"
inherit libretro-core

DESCRIPTION="Virtual Jaguar libretro port (Atari Jaguar)"
HOMEPAGE="https://github.com/libretro/virtualjaguar-libretro"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
