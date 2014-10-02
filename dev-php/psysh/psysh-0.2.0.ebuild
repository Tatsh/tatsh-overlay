# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="An interactive shell for modern PHP."
HOMEPAGE="http://psysh.org/"
SRC_URI="http://psysh.org/psysh -> psysh-${PV}.phar"
# Unfortunately the author leaves no way to know what version we are getting
# from his site

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} >=dev-lang/php-5.3.29"

S="${DISTDIR}"

src_unpack () {
	einfo Nothing to unpack
}

src_install () {
	cp -L psysh-$PV.phar psysh
	exeinto /usr/bin
	doexe psysh
}
