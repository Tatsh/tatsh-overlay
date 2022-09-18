# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Obsolete miscfilters package for VapourSynth."
HOMEPAGE="https://github.com/vapoursynth/vs-miscfilters-obsolete"
SHA="07e0589a381f7deb3bf533bb459a94482bccc5c7"
SRC_URI="https://github.com/vapoursynth/vs-miscfilters-obsolete/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"

S="${WORKDIR}/${PN}-${SHA}"
