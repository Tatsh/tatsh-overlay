# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AMD FidelityFX Contrast Adaptive Sharpening."
HOMEPAGE="https://gist.github.com/agyild/bbb4e58298b2f86aa24da3032a0d2ee6"
GIST_ID="bbb4e58298b2f86aa24da3032a0d2ee6"
SHA="10e4ca1b6ef173b64391ce2c81b9a95fcd095931"
SRC_URI="https://gist.github.com/agyild/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${GIST_ID}-${SHA}"

src_install() {
	insinto /usr/share/mpv/shaders
	doins *.glsl
}

pkg_postinst() {
	einfo
	einfo "To use the shader, specify --glsl-shader=<PATH> or use the option"
	einfo "in the configuration file."
	einfo
}
