# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="Shader for mpv."
HOMEPAGE="https://gist.github.com/igv/a015fc885d5c22e6891820ad89555637"
GIST_ID="a015fc885d5c22e6891820ad89555637"
SHA="7c151e0af2281ae6657809be1f3c5efe0e325c38"
SRC_URI="https://gist.github.com/igv/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"
BDEPEND="app-arch/unzip"

LICENSE="MIT"
KEYWORDS="~amd64"

S="${WORKDIR}/${GIST_ID}-${SHA}"

MPV_SHADER_FILES=(KrigBilateral.glsl)
