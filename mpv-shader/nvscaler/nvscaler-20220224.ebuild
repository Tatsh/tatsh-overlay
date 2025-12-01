# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="NVIDIA image scaling v1.0.2 for mpv."
HOMEPAGE="https://gist.github.com/agyild/7e8951915b2bf24526a9343d951db214"
GIST_ID="7e8951915b2bf24526a9343d951db214"
SHA="05f00864228871ffd157daa9beb2db8fa7412cfa"
SRC_URI="https://gist.github.com/agyild/${GIST_ID}/archive/${SHA}.zip -> ${P}.zip"
S="${WORKDIR}/${GIST_ID}-${SHA}"
LICENSE="MIT"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

MPV_SHADER_FILES=(NVScaler.glsl NVSharpen.glsl)
