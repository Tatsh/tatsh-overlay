# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="An FFmpeg based library and VapourSynth plugin for easy frame accurate access"
HOMEPAGE="https://github.com/FFMS/ffms2"
SRC_URI="https://github.com/FFMS/${PN}/archive/${PV:0:4}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/ffmpeg-9-r2"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV:0:4}"

src_prepare () {
	eautoreconf
	default
}

src_install () {
	# TODO Documentation based on the *.md in doc/ directory; convert to HTML?
	dodoc README.md
	default
	keepdir /usr/lib/vapoursynth/
	dosym "/usr/lib/libffms2.so" "/usr/lib/vapoursynth/libffms2.so"
}
