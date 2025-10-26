# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A very slow edge directed interpolation filter (renewed)."
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth
	dev-libs/boost
	virtual/opencl"
RDEPEND="dev-libs/opencl-icd-loader"

S="${WORKDIR}/VapourSynth-EEDI3-r${PV}"
