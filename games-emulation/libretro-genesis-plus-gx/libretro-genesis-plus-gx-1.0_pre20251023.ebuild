# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/Genesis-Plus-GX"
LIBRETRO_COMMIT_SHA="cecccacf767b1c8e86af3e315223b052a7f81b95"
inherit libretro-core

DESCRIPTION="libretro implementation of Genesis Plus GX. \
(Sega Genesis/Sega CD)"
HOMEPAGE="https://github.com/libretro/Genesis-Plus-GX"
LICENSE="GPGX"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="virtual/zlib"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

LIBRETRO_CORE_NAME=genesis_plus_gx
