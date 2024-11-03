# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A filter for smoothing of fluctuations"
HOMEPAGE="https://github.com/dubhater/vapoursynth-fluxsmooth"
SRC_URI="https://github.com/dubhater/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
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
	rm "${ED}/usr/$(get_libdir)/vapoursynth/libfluxsmooth.la" || die
}
