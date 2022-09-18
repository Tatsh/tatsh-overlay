# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An FFmpeg based library and VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
SHA="ff61bca13e2c5fb99c0450620c9244f415ec29c4"
SRC_URI="https://github.com/FFMS/ffms2/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=virtual/ffmpeg-9-r2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare () {
	mkdir -p src/config || die
	eautoreconf
	default
}

src_configure() {
	econf $(use_enable debug)
}

src_install () {
	default
	keepdir /usr/$(get_libdir)/vapoursynth/
	dosym /usr/$(get_libdir)/libffms2.so /usr/$(get_libdir)/vapoursynth/libffms2.so
	einstalldocs
}
