# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="A heads up display for Git."
HOMEPAGE="https://github.com/michaeldfallen/git-radar"
MY_SHA="2ac25e3d1047cdf19f15bc894ff39449b83d65d4"
SRC_URI="https://github.com/michaeldfallen/git-radar/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="dev-vcs/git"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${MY_SHA}"

src_compile() {
	:
}

src_install() {
	insinto /usr/share/${PN}
	doins radar-base.sh
	exeinto /usr/share/${PN}
	doexe ${PN} prompt.zsh prompt.bash fetch.sh
	dosym /usr/share/${PN}/${PN} /usr/bin/${PN}
	einstalldocs
}
