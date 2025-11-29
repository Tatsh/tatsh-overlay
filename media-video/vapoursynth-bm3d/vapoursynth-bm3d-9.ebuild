# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="BM3D denoising filter for VapourSynth"
HOMEPAGE="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D"
SRC_URI="https://github.com/HomeOfVapourSynthEvolution/VapourSynth-BM3D/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/VapourSynth-BM3D-r${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth sci-libs/fftw"
RDEPEND="${DEPEND}"
