# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VapourSynth port of RemoveGrain and Repair plugins from Avisynth"
HOMEPAGE="https://github.com/vapoursynth/vs-removegrain"
SHA="ea3d1566b7d82e1efb2f30612d6951dc61ebba65"
SRC_URI="https://github.com/vapoursynth/vs-removegrain/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"
