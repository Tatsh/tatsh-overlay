# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="Downscaler shader for mpv."
HOMEPAGE="https://gist.github.com/igv/36508af3ffc84410fe39761d6969be10"
GIST_ID="36508af3ffc84410fe39761d6969be10"
SHA="6998ff663a135376dbaeb6f038e944d806a9b9d9"
SRC_URI="https://gist.github.com/igv/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"
BDEPEND="app-arch/unzip"

LICENSE="LGPL-3"
KEYWORDS="~amd64"

S="${WORKDIR}/${GIST_ID}-${SHA}"

MPV_SHADER_FILES=(SSimDownscaler.glsl)
