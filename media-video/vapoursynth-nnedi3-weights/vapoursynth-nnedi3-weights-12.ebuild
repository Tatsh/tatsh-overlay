# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="nnedi3 weights.bin file"
HOMEPAGE="https://github.com/dubhater/vapoursynth-nnedi3"
SRC_URI="https://github.com/dubhater/${PN/-weights}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P/-weights}"

src_install () {
	dodoc gpl2.txt readme.rst
	insinto /usr/share/${PN}
	doins src/nnedi3_weights.bin
}
