# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/yabause"
LIBRETRO_COMMIT_SHA="7cb15b8f9eea5a6fa7cae34468a6989522bcba75"
inherit libretro-core

DESCRIPTION="Yabause libretro port (Sega Saturn)"
HOMEPAGE="https://github.com/libretro/yabause"
S="${WORKDIR}/yabause-${LIBRETRO_COMMIT_SHA}/yabause/src/libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/flac:=
	virtual/zlib"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-makefile.common-add-system_z.patch"
	"${FILESDIR}/${PN}-0002-makefile.common-add-system_f.patch"
)

MYEMAKEARGS=( "SYSTEM_FLAC=1" "SYSTEM_ZLIB=1" )
