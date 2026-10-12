# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-vb-libretro"
LIBRETRO_COMMIT_SHA="3f53a40bf8aa18777514fd4b220960427e312a3f"
inherit libretro-core

DESCRIPTION="Beetle VB libretro port (Nintendo Virtual Boy, Mednafen fork)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
