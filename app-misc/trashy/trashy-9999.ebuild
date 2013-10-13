# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="A sane, portable rm intermediary"
HOMEPAGE="http://slackermedia.info/trashy/"
EGIT_REPO_URI="git://gitorious.org/trashy/trashy.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install () {
	cd "${S}"
	exeinto /usr/bin
	doexe trash
	doman trash.8
	dodoc README

	#if use alias; then
	#	echo "alias rm='trash'" > 99trashy
	#	doenvd 99trashy || die "doenv failed"
	#fi

	einfo
	einfo "You may find it useful to alias 'trash' to take over 'rm'"
	einfo "When you need to use rm, you can type rm with a back-slash preceding"
	einfo "To alias in Bash, use 'alias rm="trash"' or similar in your ~/.bash_profile or similar file"
	einfo "Don't forget to re-source if you will continue using that shell"
	einfo
}
