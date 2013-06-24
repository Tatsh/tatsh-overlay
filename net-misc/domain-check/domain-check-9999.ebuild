# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Domain checking utility"
HOMEPAGE="http://linuxmafia.com/~rick/preventing-expiration.html"
SRC_URI="ftp://linuxmafia.com/pub/linux/network/domain-check"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jwhois"

RDEPEND="jwhois? ( net-misc/jwhois )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp -vL "${DISTDIR}/domain-check" "${WORKDIR}"
}

src_install() {
	exeinto /usr/bin
	doexe domain-check
}
