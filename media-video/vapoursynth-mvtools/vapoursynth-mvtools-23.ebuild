# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION=""
HOMEPAGE="https://github.com/dubhater/vapoursynth-mvtools/"
SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vapoursynth-37
		>=sci-libs/fftw-3.3.4"
RDEPEND="${DEPEND}"

src_prepare () {
	eautoreconf
	default
}

src_install () {
	default
	dosym /usr/$(get_libdir)/libmvtools.so /usr/$(get_libdir)/vapoursynth/libmvtools.so
	einstalldocs
}
