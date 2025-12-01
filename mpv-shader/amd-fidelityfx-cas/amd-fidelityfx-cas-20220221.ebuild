# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="AMD FidelityFX Contrast Adaptive Sharpening."
HOMEPAGE="https://gist.github.com/agyild/bbb4e58298b2f86aa24da3032a0d2ee6"
GIST_ID="bbb4e58298b2f86aa24da3032a0d2ee6"
SHA="10e4ca1b6ef173b64391ce2c81b9a95fcd095931"
SRC_URI="https://gist.github.com/agyild/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"
S="${WORKDIR}/${GIST_ID}-${SHA}"
LICENSE="MIT"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

MPV_SHADER_FILES=(CAS-scaled.glsl CAS.glsl)
