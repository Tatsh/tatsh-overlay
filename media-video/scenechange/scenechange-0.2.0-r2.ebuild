# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Scene change detection plugin for VapourSynth"
HOMEPAGE="https://forum.doom9.org/showthread.php?t=166769"
SRC_URI="https://raw.githubusercontent.com/Tatsh/${PN}/60c6ad25f33950ac3f11803197d915b110e32458/src/Makefile -> ${P}-Makefile
	https://github.com/Tatsh/${PN}/archive/v0.2.0-2.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-video/vapoursynth-37"

S="${WORKDIR}/${P}-2/src"

src_prepare () {
	cp "${DISTDIR}/${P}-Makefile" "${S}/Makefile"
	default
}

src_compile () {
	emake LDFLAGS="$LDFLAGS -shared -fPIC -L."
}

src_install () {
	keepdir /usr/$(get_libdir)/vapoursynth
	exeinto /usr/$(get_libdir)/vapoursynth
	doexe libscenechange.so libtemporalsoften2.so
}
