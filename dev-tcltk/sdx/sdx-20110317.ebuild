# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A utility for making and unpacking starkits."
HOMEPAGE="https://www.equi4.com/starkit/sdx.html"
SRC_URI="https://chiselapp.com/user/aspect/repository/${PN}/raw/${P}.kit?name=1a77b0b5bc8cfcf2df2ef051a511e9187103ce0c -> ${P}.kit"

S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="dev-tcltk/tclkit"
DEPEND="${RDEPEND}"
RESTRICT="strip"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}/${P}.kit" "${PN}.kit"
}
