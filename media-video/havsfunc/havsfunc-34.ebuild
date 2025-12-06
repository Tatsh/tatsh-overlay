# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling

PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1

DESCRIPTION="Holy's ported AviSynth functions for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/havsfunc"
SHA="da4340f1a1b462cbc4ef543178e4c35f15813e7d"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=">=media-video/ffms2-2.23.1
	>=media-video/fmtconv-20
	>=media-video/mvsfunc-8[${PYTHON_USEDEP}]
	>=media-video/scenechange-0.2.0-r2
	>=media-video/vapoursynth-37[vspipe]
	>=media-video/vapoursynth-mvtools-17
	>=media-video/vapoursynth-nnedi3-11
	dev-python/vsutil[${PYTHON_USEDEP}]
	media-video/vs-jetpack[${PYTHON_USEDEP}]
	media-video/vapoursynth-eedi3
	media-video/vapoursynth-fft3dfilter
	media-video/vs-miscfilters-obsolete
	media-video/znedi3"
