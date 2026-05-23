# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/virtualjaguar-libretro"
LIBRETRO_COMMIT_SHA="18828045f76a803206ebffc9b8d57842287b7552"
inherit libretro-core

DESCRIPTION="Virtual Jaguar libretro port (Atari Jaguar)"
HOMEPAGE="https://github.com/libretro/virtualjaguar-libretro"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
