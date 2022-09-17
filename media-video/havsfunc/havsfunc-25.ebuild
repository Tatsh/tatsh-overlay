# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-r1 python-utils-r1

DESCRIPTION="Holy's ported AviSynth functions for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/${PN}/archive/r25.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-video/ffms2-2.23.1
	>=media-video/fmtconv-20
	>=media-video/mvsfunc-8
	>=media-video/scenechange-0.2.0-r2
	>=media-video/vapoursynth-37[eedi3,miscfilters,plugins,vspipe]
	>=media-video/vapoursynth-mvtools-17
	>=media-video/vapoursynth-nnedi3-11"

S="${WORKDIR}/${PN}-r${PV}"

src_prepare () {
	# TODO Add https://github.com/dubhater/vapoursynth-adjust
	sed -e '3s/.*//' -i havsfunc.py
	default
}

src_install () {
	python_foreach_impl python_domodule havsfunc.py
}
