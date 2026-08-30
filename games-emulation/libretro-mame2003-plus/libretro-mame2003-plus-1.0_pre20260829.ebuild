# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/mame2003-plus-libretro"
LIBRETRO_COMMIT_SHA="d6bf36f65f36853120d7e97cdf4fa3720de66728"
inherit libretro-core

DESCRIPTION="MAME (0.78) with extra features for libretro."
HOMEPAGE="https://github.com/libretro/mame2003-plus-libretro"
LICENSE="MAME-GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

LIBRETRO_CORE_LIB_FILE="${S}"/mame2003_plus_libretro.so
