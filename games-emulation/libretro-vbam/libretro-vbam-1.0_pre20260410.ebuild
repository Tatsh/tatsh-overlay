# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/vbam-libretro"
LIBRETRO_COMMIT_SHA="e8b2875d6cad10fc3c7c9f57bb5f1acc324d7c10"
inherit libretro-core

DESCRIPTION="VBA-M libretro port (Nintendo Game Boy Advance / Game Boy / Game Boy Color)"
HOMEPAGE="https://github.com/libretro/vbam-libretro"
S="${WORKDIR}/vbam-libretro-${LIBRETRO_COMMIT_SHA}/src/libretro"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
