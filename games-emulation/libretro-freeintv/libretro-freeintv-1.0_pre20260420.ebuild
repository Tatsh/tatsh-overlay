# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/FreeIntv"
LIBRETRO_COMMIT_SHA="428915baf2bfc032fc03e645f4f8f9c6c3144979"
inherit libretro-core

DESCRIPTION="FreeIntv libretro port (Mattel Intellivision)"
HOMEPAGE="https://github.com/libretro/FreeIntv"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"
