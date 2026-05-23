# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-vb-libretro"
LIBRETRO_COMMIT_SHA="1275bd7bddf2166be5a10e45c26c5c2a61370658"
inherit libretro-core

DESCRIPTION="Beetle VB libretro port (Nintendo Virtual Boy, Mednafen fork)"
HOMEPAGE="https://github.com/libretro/beetle-vb-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
