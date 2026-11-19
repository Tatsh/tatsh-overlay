# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/mame2003-plus-libretro"
LIBRETRO_COMMIT_SHA="2a60eda71ae0fea543a76a43b5d58086a5485256"
inherit libretro-core

DESCRIPTION="MAME (0.78) with extra features for libretro"
HOMEPAGE="https://github.com/libretro/mame2003-plus-libretro"
LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

LIBRETRO_CORE_LIB_FILE="${S}"/mame2003_plus_libretro.so
