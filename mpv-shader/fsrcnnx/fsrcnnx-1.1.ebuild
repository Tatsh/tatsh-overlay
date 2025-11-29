# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-shader

DESCRIPTION="Shaders implemnting FSRCNNX for upscaling."
HOMEPAGE="https://github.com/igv/FSRCNN-TensorFlow"
MY_PN="${PN^^}"
SRC_URI="https://github.com/igv/FSRCNN-TensorFlow/releases/download/${PV}/${MY_PN}_x2_16-0-4-1.glsl
	https://github.com/igv/FSRCNN-TensorFlow/releases/download/${PV}/${MY_PN}_x2_8-0-4-1.glsl"
S="${WORKDIR}"
LICENSE="GPL-3"
KEYWORDS="~amd64"

MPV_SHADER_FILES=(
	"${DISTDIR}/${MY_PN}_x2_16-0-4-1.glsl"
	"${DISTDIR}/${MY_PN}_x2_8-0-4-1.glsl"
)
