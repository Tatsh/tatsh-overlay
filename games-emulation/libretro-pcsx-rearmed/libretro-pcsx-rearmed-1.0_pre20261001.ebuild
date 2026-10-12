# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/pcsx_rearmed"
LIBRETRO_COMMIT_SHA="c8816799b50388e61cfe237fe2cdbb7d8175f20a"

inherit libretro-core

DESCRIPTION="libretro implementation of PCSX ReARMed. (PlayStation)"
HOMEPAGE="https://github.com/libretro/pcsx_rearmed"
LIBPICOFE_SHA="a2697389e76744cfa0c56c13a172845c45ede719"
SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}-${LIBRETRO_COMMIT_SHA:0:7}.tar.gz
	https://github.com/notaz/libpicofe/archive/${LIBPICOFE_SHA}.tar.gz -> libpicofe-${LIBPICOFE_SHA:0:7}.tar.gz "
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

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
