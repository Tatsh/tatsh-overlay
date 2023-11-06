# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="Holy's ported AviSynth functions for VapourSynth"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=166582"
SHA="f11d79c98589c9dcb5b10beec35b631db68b495c"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/havsfunc/archive/${SHA}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=media-video/ffms2-2.23.1
	>=media-video/fmtconv-20
	>=media-video/mvsfunc-8[${PYTHON_USEDEP}]
	>=media-video/scenechange-0.2.0-r2
	>=media-video/vapoursynth-37[vspipe]
	>=media-video/vapoursynth-mvtools-17
	>=media-video/vapoursynth-nnedi3-11
	dev-python/vsutil[${PYTHON_USEDEP}]
	media-libs/vs-denoise[${PYTHON_USEDEP}]
	media-video/vapoursynth-eedi3
	media-video/vapoursynth-fft3dfilter
	media-video/vs-miscfilters-obsolete
	media-video/znedi3"

S="${WORKDIR}/${PN}-${SHA}"
