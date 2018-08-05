# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A video processing framework with simplicity in mind."
HOMEPAGE="http://www.vapoursynth.com/"
SRC_URI="https://github.com/vapoursynth/${PN}/archive/R${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="guard-pattern +x86-asm +vsscript +vspipe +plugins +subtext +eedi3 imwri +miscfilters +morpho +ocr +removegrain +vinverse +vivtc"

# TODO Fix imwri detection of ImageMagick
# TODO Do not allow x86-asm USE flag if not amd64/x86
# TODO doc USE flag (requires Sphinx)
# TODO Install for every Python 3.x implementation
DEPEND=">=media-libs/zimg-2.4
		subtext? ( >=virtual/ffmpeg-9-r2 >=media-libs/libass-0.13.6 )
		x86-asm? ( >=dev-lang/yasm-1.3.0 )
		ocr? ( app-text/tesseract )
		imwri? ( media-gfx/imagemagick )
		vsscript? ( >=dev-lang/python-3.4 )"
REQUIRED_USE="vspipe? ( vsscript )"
RDEPEND=""

S="${WORKDIR}/${PN}-R${PV}"

src_prepare () {
	eautoreconf
	default
}

src_configure () {
	x86_asm=
	if use amd64 || use x86; then
		x86_asm=$(use_enable x86-asm )
	fi
	econf \
		$(use_enable guard-pattern ) \
		"$x86_asm" \
		$(use_enable vsscript ) \
		$(use_enable vspipe ) \
		$(use_enable plugins ) \
		$(use_enable subtext ) \
		$(use_enable eedi3 ) \
		$(use_enable imwri ) \
		$(use_enable morpho ) \
		$(use_enable miscfilters ) \
		$(use_enable ocr ) \
		$(use_enable removegrain ) \
		$(use_enable vinverse ) \
		$(use_enable vivtc )
}

src_install () {
	dodoc ChangeLog COPYING.LGPLv2.1 ofl.txt
	default
}
