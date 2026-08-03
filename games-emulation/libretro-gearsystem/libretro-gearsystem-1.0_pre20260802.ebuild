# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="drhelius/Gearsystem"
LIBRETRO_COMMIT_SHA="034c993c99d48b0e17db4f7a2b6994d51a3b71e2"
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
