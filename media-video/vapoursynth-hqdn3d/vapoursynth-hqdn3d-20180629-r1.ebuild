# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Port of hqdn3d from AviSynth"
HOMEPAGE="https://github.com/Hinterwaeldlers/vapoursynth-hqdn3d"
SHA="eb820cb23f7dc47eb67ea95def8a09ab69251d30"
SRC_URI="https://github.com/Hinterwaeldlers/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

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
