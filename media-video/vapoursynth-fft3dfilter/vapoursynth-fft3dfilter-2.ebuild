# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VapourSynth port of RemoveGrain and Repair plugins from Avisynth"
HOMEPAGE="https://github.com/vapoursynth/vs-removegrain"
SRC_URI="https://github.com/myrsloik/VapourSynth-FFT3DFilter/archive/refs/tags/R2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/VapourSynth-FFT3DFilter-R${PV}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth
	sci-libs/fftw"
RDEPEND="${DEPEND}"
