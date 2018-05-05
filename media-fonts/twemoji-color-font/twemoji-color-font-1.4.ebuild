# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit font

DESCRIPTION="Color emoji SVGinOT font using Twitter Unicode 10 emoji."
HOMEPAGE="https://github.com/eosrei/twemoji-color-font"
SRC_URI="https://github.com/eosrei/twemoji-color-font/archive/v1.4.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-gfx/scfbuild
	>=media-gfx/imagemagick-6.9.9.31
	>=media-gfx/inkscape-0.92.2
	>=media-gfx/potrace-1.15"
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
FONT_S="${S}/build"
FONT_CONF=( linux/fontconfig/56-twemoji-color.conf )

src_prepare() {
	sed -i Makefile -e 's/svgo /echo svgo /g'
	default
}

src_compile() {
	local -r tmpdir="${S}/tmp"
	mkdir "$tmpdir"
	emake SCFBUILD="${EPREFIX}/usr/bin/scfbuild" TMP="$tmpdir" 'build/TwitterColorEmoji-SVGinOT.ttf'
}
