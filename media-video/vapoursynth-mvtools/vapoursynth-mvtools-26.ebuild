# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Motion compensation, etc for VapourSynth."
HOMEPAGE="https://github.com/dubhater/vapoursynth-mvtools/"
SRC_URI="https://github.com/dubhater/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="dev-lang/nasm"
DEPEND=">=media-video/vapoursynth-37
		>=sci-libs/fftw-3.3.4"
RDEPEND="${DEPEND}"

src_configure() {
	emesonargs=(
		"--libdir=/usr/$(get_libdir)/vapoursynth"
		"-Dwith_nasm=${EPREFIX}/usr/bin/nasm"
	)
	meson_src_configure
}
