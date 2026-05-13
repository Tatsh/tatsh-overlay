# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-handy"
LIBRETRO_COMMIT_SHA="bc55d462f0b2d6b073ea93dc552ebd73cec60fd1"
inherit libretro-core

DESCRIPTION="Handy libretro port (Atari Lynx)"
HOMEPAGE="https://github.com/libretro/libretro-handy"
LICENSE="ZLIB LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
