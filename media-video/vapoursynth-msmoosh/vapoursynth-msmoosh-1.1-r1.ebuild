# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="MSharpen and MSmooth for VapourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-msmoosh"
SRC_URI="https://github.com/dubhater/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"
RDEPEND="${DEPEND}"

DOCS=( readme.rst )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf "--libdir=/usr/$(get_libdir)/vapoursynth"
}

src_compile() {
	emake
}

src_install() {
	emake install DESTDIR="${D}"
	einstalldocs
}
