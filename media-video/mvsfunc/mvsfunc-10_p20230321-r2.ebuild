# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1

DESCRIPTION="mawen1250's VapourSynth functions"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/mvsfunc"
SHA="865c7486ca860d323754ec4774bc4cca540a7076"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/mvsfunc/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=media-video/vapoursynth-37[${PYTHON_USEDEP}]
	media-video/fmtconv
	media-video/vapoursynth-bm3d"

S="${WORKDIR}/${PN}-${SHA}"
