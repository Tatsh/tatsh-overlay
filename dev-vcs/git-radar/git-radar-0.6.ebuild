# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=7

DESCRIPTION="A heads up display for Git."
HOMEPAGE="https://github.com/michaeldfallen/git-radar"
SRC_URI="https://github.com/michaeldfallen/git-radar/releases/download/v0.6/git-radar-0.6.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-vcs/git"
DEPEND="${RDEPEND}"

DOCS=( LICENSE README.md )

src_compile() {
	einfo 'Nothing to compile'
}

src_install() {
	insinto /usr/share/${PN}
	doins radar-base.sh
	exeinto /usr/share/${PN}
	doexe ${PN} prompt.zsh prompt.bash fetch.sh
	dosym /usr/share/${PN}/${PN} /usr/bin/${PN}
	einstalldocs
}
