# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/gambatte-libretro"
LIBRETRO_COMMIT_SHA="4c1b4c26c8db94663196bad187b58fe8e9162b4f"
inherit libretro-core

DESCRIPTION="Gambatte libretro port (Nintendo Game Boy / Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
