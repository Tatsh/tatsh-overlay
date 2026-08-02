# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/yabause"
LIBRETRO_COMMIT_SHA="8926b0c6c347f8c5c755911ddb0ac695420ffbf8"
inherit libretro-core

DESCRIPTION="Yabause libretro port (Sega Saturn)"
HOMEPAGE="https://github.com/libretro/yabause"
S="${WORKDIR}/yabause-${LIBRETRO_COMMIT_SHA}/yabause/src/libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	media-libs/libchdr
	media-libs/flac:=
	virtual/zlib"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-makefile.common-add-system_z.patch"
	"${FILESDIR}/${PN}-0002-makefile.common-add-system_f.patch"
	"${FILESDIR}/${PN}-0003-makefile.common-add-system_l.patch"
)

MYEMAKEARGS=( "SYSTEM_FLAC=1" "SYSTEM_LIBCHDR=1" "SYSTEM_ZLIB=1" )

src_prepare() {
	libretro-core_src_prepare

	# De-vendor libchdr: drop bundled libchdr (and its deps/lzma) so the
	# system library (media-libs/libchdr) is used via SYSTEM_LIBCHDR=1.
	rm -rf "${S}/../../libchdr" || die
}
