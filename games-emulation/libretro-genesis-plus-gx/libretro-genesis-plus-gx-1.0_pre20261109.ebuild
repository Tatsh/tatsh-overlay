# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/Genesis-Plus-GX"
LIBRETRO_COMMIT_SHA="f27655b592ef43f317272d79883bcaa10d3ac8ad"
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
