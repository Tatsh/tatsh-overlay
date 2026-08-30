# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/gambatte-libretro"
LIBRETRO_COMMIT_SHA="96174369b3c30d9fc57c926fa3379c273dc6a9a5"
inherit libretro-core

DESCRIPTION="Gambatte libretro port (Nintendo Game Boy / Game Boy Color)"
HOMEPAGE="https://github.com/libretro/gambatte-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
