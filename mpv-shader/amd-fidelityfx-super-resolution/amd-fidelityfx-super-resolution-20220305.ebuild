# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AMD FidelityFX Super Resolution v1.0.2 for mpv."
HOMEPAGE="https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5"
GIST_ID="82219c545228d70c5604f865ce0b0ce5"
SHA="2623d743b9c23f500ba086f05b385dcb1557e15d"
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
