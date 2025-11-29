# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="AMD FidelityFX Super Resolution v1.0.2 for mpv."
HOMEPAGE="https://gist.github.com/agyild/82219c545228d70c5604f865ce0b0ce5"
SHA="2623d743b9c23f500ba086f05b385dcb1557e15d"
SRC_URI="https://gist.github.com/agyild/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"
S="${WORKDIR}/${GIST_ID}-${SHA}"
LICENSE="MIT"
KEYWORDS="~amd64"

GIST_ID="82219c545228d70c5604f865ce0b0ce5"
BDEPEND="app-arch/unzip"

MPV_SHADER_FILES=(FSR.glsl)
