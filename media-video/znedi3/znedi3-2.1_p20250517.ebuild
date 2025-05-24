# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="nnedi3 filter."
HOMEPAGE="https://github.com/sekrit-twc/znedi3"
SHA="47e7698f481577ac325567bb553134520939f1ff"
GRAPHENGINE_SHA="f06d7cb4d589ea4657f01b13613efb7437c8ecda"
VSXX_SHA="de38f0e128c85782494ae00565698a2b25e87869"
SRC_URI="https://github.com/sekrit-twc/znedi3/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/sekrit-twc/graphengine/archive/${GRAPHENGINE_SHA}.tar.gz -> ${P}-graphengine-${GRAPHENGINE_SHA:0:7}.tar.gz
	https://github.com/sekrit-twc/vsxx/archive/${VSXX_SHA}.tar.gz -> ${P}-vsxx-${VSXX_SHA:0:7}.tar.gz"

LICENSE="WTFPL-2 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	rmdir graphengine vsxx || die
	mv ../graphengine-${GRAPHENGINE_SHA} graphengine || die
	mv ../vsxx-${VSXX_SHA} vsxx || die
	default
}

src_compile() {
	emake X86=1
}

src_install() {
	mkdir -p "${ED}/usr/$(get_libdir)/vapoursynth" || die
	cp vsznedi3.so "${ED}/usr/$(get_libdir)/vapoursynth/" || die
	einstalldocs
}
