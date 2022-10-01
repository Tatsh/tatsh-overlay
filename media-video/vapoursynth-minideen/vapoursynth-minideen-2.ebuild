# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="Spatial denoising filter for pourSynth"
HOMEPAGE="https://github.com/dubhater/vapoursynth-minideen"
SRC_URI="https://github.com/dubhater/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/vapoursynth"
RDEPEND="${DEPEND}"

DOCS=( readme.rst )

src_configure() {
	append-cxxflags -fpeel-loops
	emesonargs=(
		--libdir "/usr/$(get_libdir)/vapoursynth"
	)
	meson_src_configure
}
