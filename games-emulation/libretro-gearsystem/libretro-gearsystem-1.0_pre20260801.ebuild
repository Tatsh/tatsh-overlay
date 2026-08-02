# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="drhelius/Gearsystem"
LIBRETRO_COMMIT_SHA="130d4c91583248b8703e334cb2f1cf5bb84c3e8d"
inherit libretro-core

DESCRIPTION="Gearsystem libretro port (Sega Master System / Game Gear / SG-1000)"
HOMEPAGE="https://github.com/drhelius/Gearsystem"
S="${WORKDIR}/Gearsystem-${LIBRETRO_COMMIT_SHA}/platforms/libretro"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/miniz"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-libretro-makefile-add-system.patch"
)

MYEMAKEARGS=( "SYSTEM_MINIZ=1" )
