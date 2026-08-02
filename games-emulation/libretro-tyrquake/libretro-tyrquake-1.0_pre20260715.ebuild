# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/tyrquake"
LIBRETRO_COMMIT_SHA="e57bb11597e8a00380f30f2627d219da960cf69a"

inherit libretro-core

DESCRIPTION="libretro implementation of TyrQuake. (Quake)"
HOMEPAGE="https://github.com/libretro/tyrquake"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
