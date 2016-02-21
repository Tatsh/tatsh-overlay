# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A heads up display for Git."
HOMEPAGE="https://github.com/michaeldfallen/git-radar"
SRC_URI="https://github.com/michaeldfallen/git-radar/releases/download/v0.6/git-radar-0.6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	einfo 'Nothing to compile'
}

src_install() {
	insinto /usr/share/${P}
	doins radar-base.sh
	exeinto /usr/share/${P}
	doexe ${PN} prompt.zsh prompt.bash fetch.sh
	dosym /usr/share/${P}/${PN} /usr/bin/${PN}
	dodoc LICENSE README.md
}
