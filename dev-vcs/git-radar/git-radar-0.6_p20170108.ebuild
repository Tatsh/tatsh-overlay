# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A heads up display for Git."
HOMEPAGE="https://github.com/michaeldfallen/git-radar"
SHA="2ac25e3d1047cdf19f15bc894ff39449b83d65d4"
SRC_URI="https://github.com/michaeldfallen/git-radar/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"

RDEPEND="dev-vcs/git"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_compile() {
	:
}

src_install() {
	insinto /usr/share/${PN}
	doins radar-base.sh
	exeinto /usr/share/${PN}
	doexe ${PN} prompt.zsh prompt.bash fetch.sh
	dosym "${EPREFIX}/usr/share/${PN}/${PN}" /usr/bin/${PN}
	einstalldocs
}
