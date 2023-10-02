# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An FFmpeg based library and VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
SHA="ef243ab40b8d4b6d18874c6cef0da1a2f55a6a45"
SRC_URI="https://github.com/FFMS/ffms2/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="<media-video/ffmpeg-5 sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare () {
	mkdir -p src/config || die
	eautoreconf
	default
}

src_configure() {
	econf "$(use_enable debug)"
}

src_install () {
	default
	keepdir "/usr/$(get_libdir)/vapoursynth/"
	dosym -r "/usr/$(get_libdir)/libffms2.so" "/usr/$(get_libdir)/vapoursynth/libffms2.so"
	einstalldocs
}
