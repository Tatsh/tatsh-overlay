# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-r3

DESCRIPTION="Bash script to check executable properties like PIE, RELRO, etc"
HOMEPAGE="https://github.com/slimm609/checksec.sh http://www.trapkit.de/tools/checksec.html"
EGIT_REPO_URI="git://github.com/Tatsh/checksec.sh"
EGIT_BRANCH="gentoo"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/no-update.patch"
}

src_install () {
	exeinto /usr/bin
	doexe checksec

	dodoc changelog README.md
}
