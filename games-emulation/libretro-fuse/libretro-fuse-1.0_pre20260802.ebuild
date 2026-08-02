# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LIBRETRO_REPO_NAME="libretro/fuse-libretro"
LIBRETRO_COMMIT_SHA="a183c374f5f11f505e523351bb26b825565a6c81"

inherit libretro-core

DESCRIPTION="A port of the Fuse Unix Spectrum Emulator to libretro"
HOMEPAGE="https://github.com/libretro/fuse-libretro"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
