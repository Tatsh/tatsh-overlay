# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="Shader for mpv."
HOMEPAGE="https://gist.github.com/igv/a015fc885d5c22e6891820ad89555637"
GIST_ID="a015fc885d5c22e6891820ad89555637"
SHA="038064821c5f768dfc6c00261535018d5932cdd5"
SRC_URI="https://gist.github.com/igv/${GIST_ID}/archive/${SHA}.zip -> ${P}-${SHA:0:7}.zip"
S="${WORKDIR}/${GIST_ID}-${SHA}"
LICENSE="MIT"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

MPV_SHADER_FILES=(KrigBilateral.glsl)
