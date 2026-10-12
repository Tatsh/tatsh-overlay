# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="drhelius/Gearsystem"
LIBRETRO_COMMIT_SHA="f58ed102b6abd10a522ef17d5716c890083115b9"
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
