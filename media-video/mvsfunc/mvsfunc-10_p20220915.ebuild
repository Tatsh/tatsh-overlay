# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/mvsfunc"
SHA="f3167b8a2789ea1527e5249b02906420c95f2c7b"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${DEPEND} >=media-video/vapoursynth-37"

S="${WORKDIR}/${PN}-${SHA}"
