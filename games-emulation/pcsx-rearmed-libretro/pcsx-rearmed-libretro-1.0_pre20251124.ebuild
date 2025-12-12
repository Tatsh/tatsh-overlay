# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/pcsx_rearmed"
LIBRETRO_COMMIT_SHA="9059485691c44cb3a555464b06eddfb1082d586c"

inherit libretro-core

DESCRIPTION="libretro implementation of PCSX ReARMed. (PlayStation)"
HOMEPAGE="https://github.com/libretro/pcsx_rearmed"
LIBPICOFE_SHA="da09f8f20da6548e1debf4abb9840eb9f130678d"
SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}-${LIBRETRO_COMMIT_SHA:0:7}.tar.gz
	https://github.com/notaz/libpicofe/archive/${LIBPICOFE_SHA}.tar.gz -> libpicofe-${LIBPICOFE_SHA:0:7}.tar.gz "
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="GPL-2"
SLOT="0"

DEPEND="media-libs/libpng:0
	media-libs/libsdl
	sys-libs/zlib-ng"
RDEPEND="${DEPEND}
		games-emulation/libretro-info"

src_prepare() {
	mv -T "${WORKDIR}/libpicofe-${LIBPICOFE_SHA}" frontend/libpicofe || die
	libretro-core_src_prepare
	# shellcheck disable=SC2016
	sed -i configure \
		-e 's/*) echo "ERROR: unknown option $opt"; show_help="yes"/*) echo "unknown option $opt"/'
}
