# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-vb-libretro"
LIBRETRO_COMMIT_SHA="d5ae54c8e23b573a3b34e888b2d48a588027e92c"
inherit libretro-core

DESCRIPTION="Beetle VB libretro port (Nintendo Virtual Boy, Mednafen fork)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
