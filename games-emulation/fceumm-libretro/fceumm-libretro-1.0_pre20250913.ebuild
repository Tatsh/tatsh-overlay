# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/libretro-fceumm"
LIBRETRO_COMMIT_SHA="5cd4a43e16a7f3cd35628d481c347a0a98cfdfa2"
inherit libretro-core

DESCRIPTION="FCEUmm libretro port (Nintendo - NES / Famicom)"
HOMEPAGE="https://github.com/libretro/libretro-fceumm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"

LIBRETRO_CORE_NAME=fceumm
