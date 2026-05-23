# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-ngp-libretro"
LIBRETRO_COMMIT_SHA="0c81ce8991a47aac5d0a7d1ae53de75bc7ddf847"
inherit libretro-core

DESCRIPTION="Beetle NGP libretro port (SNK Neo Geo Pocket / Pocket Color, Mednafen fork)"
HOMEPAGE="https://github.com/libretro/beetle-ngp-libretro"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
