# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A very slow edge directed interpolation filter (renewed)."
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3"
SHA="d11bdb37c7a7118cd095b53d9f8fbbac02a06ac0"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-EEDI3/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"

S="${WORKDIR}/VapourSynth-EEDI3-${SHA}"
