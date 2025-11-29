# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VapourSynth port of RemoveGrain and Repair plugins from Avisynth"
HOMEPAGE="https://github.com/vapoursynth/vs-removegrain"
SHA="89ca38a6971e371bdce2778291393258daa5f03b"
SRC_URI="https://github.com/vapoursynth/vs-removegrain/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"
RDEPEND="${DEPEND}"
