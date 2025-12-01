# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GPU accelerated compression to FLAC"
HOMEPAGE="https://github.com/TokugawaHeavyIndustries/FlaLDF"
MY_PN="FlaLDF"
SRC_URI="https://github.com/TokugawaHeavyIndustries/${MY_PN}/releases/download/v${PV:0:3}b/${MY_PN}-v${PV:0:3}-2-linux-x64.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

src_install() {
	dobin "${MY_PN,,}"
}
