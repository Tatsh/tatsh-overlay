# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/fmsx-libretro"
LIBRETRO_COMMIT_SHA="9eb5f25df5397212a3e3088ca1a64db0740bbe5f"

inherit libretro-core

DESCRIPTION="Port of fMSX to the libretro API."
HOMEPAGE="https://github.com/libretro/fmsx-libretro"
LICENSE="fMSX"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
