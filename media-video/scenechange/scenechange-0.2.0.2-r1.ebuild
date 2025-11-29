# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Scene change detection plugin for VapourSynth"
HOMEPAGE="https://forum.doom9.org/showthread.php?t=166769"
SRC_URI="https://raw.githubusercontent.com/Tatsh/${PN}/60c6ad25f33950ac3f11803197d915b110e32458/src/Makefile -> ${P}-Makefile
	https://github.com/Tatsh/${PN}/archive/v$(ver_cut 1-3)-2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV:0:5}-2/src"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=media-video/vapoursynth-37"

src_prepare () {
	cp "${DISTDIR}/${P}-Makefile" "${S}/Makefile"
	default
}

src_compile () {
	emake LDFLAGS="$LDFLAGS -shared -fPIC -L."
}

src_install () {
	exeinto "/usr/$(get_libdir)/vapoursynth"
	doexe libscenechange.so libtemporalsoften2.so
}
