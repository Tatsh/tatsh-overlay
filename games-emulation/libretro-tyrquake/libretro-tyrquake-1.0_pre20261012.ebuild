# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/tyrquake"
LIBRETRO_COMMIT_SHA="67db338ff4d27fdbcead61d4e54938d758ae62cb"

inherit libretro-core

DESCRIPTION="libretro implementation of TyrQuake. (Quake)"
HOMEPAGE="https://github.com/libretro/tyrquake"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
