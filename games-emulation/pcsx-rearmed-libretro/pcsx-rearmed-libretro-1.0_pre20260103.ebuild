# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/pcsx_rearmed"
LIBRETRO_COMMIT_SHA="32e2193bcc9d937d9b1a16db43258aef51cddae8"

inherit libretro-core

DESCRIPTION="libretro implementation of PCSX ReARMed. (PlayStation)"
HOMEPAGE="https://github.com/libretro/pcsx_rearmed"
LIBPICOFE_SHA="dd11f2d723162eb1cf8e6db9f40de7db0d0b6bba"
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
