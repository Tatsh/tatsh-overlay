# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for playback of various streamed audio formats used in video games."
HOMEPAGE="https://vgmstream.org/ https://github.com/vgmstream/vgmstream"
SRC_URI="https://github.com/vgmstream/${PN}/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-r${PV}"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libatrac9
	media-libs/libogg
	media-libs/libvorbis
	media-libs/speex
	media-sound/mpg123-base
	media-video/ffmpeg:="
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-system-atrac9.patch" )

src_configure() {
	local mycmakeargs=(
		-DBUILD_AUDACIOUS=OFF
		# LIBVGMSTREAM_API is __declspec(dllexport), so the shared library only compiles with MSVC.
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_V123=OFF
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		# FSB CELT needs two ABI-incompatible celt versions built with renamed symbols, and G.719
		# needs unlicensed ITU reference code; both are fetched by the build, so they stay off.
		-DUSE_CELT=OFF
		-DUSE_G719=OFF
	)
	cmake_src_configure
}
