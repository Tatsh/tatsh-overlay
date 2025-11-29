# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="nnedi3 weights.bin file"
HOMEPAGE="https://github.com/dubhater/vapoursynth-nnedi3"
SRC_URI="https://github.com/dubhater/${PN/-weights}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/-weights}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

src_install () {
	dodoc readme.rst
	insinto "/usr/share/${PN}"
	doins src/nnedi3_weights.bin
}
