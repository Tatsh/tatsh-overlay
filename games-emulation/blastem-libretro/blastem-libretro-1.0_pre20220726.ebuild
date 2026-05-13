# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/blastem"
LIBRETRO_COMMIT_SHA="277e4a62668597d4f59cadda1cbafb844f981d45"
inherit libretro-core

DESCRIPTION="BlastEm libretro port (Sega Genesis / Mega Drive)"
HOMEPAGE="https://github.com/libretro/blastem"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/zlib"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-makefile-.-c-h-honor-host_zl.patch"
)

MYEMAKEARGS=( "HOST_ZLIB=1" )
