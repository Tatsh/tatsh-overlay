# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="A PHP script that extracts useful information from many file formats."
HOMEPAGE="http://getid3.sourceforge.net/"
EGIT_REPO_URI="git://github.com/tatsh/getid3.git"
EGIT_COMMIT="dd6ae769ff16fe80971c2b3b364e2061221e41a1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-lang/php-5.2.3"

src_install() {
	insinto /usr/share/php
	doins -r getid3

	dodoc README \
		changelog.txt \
		dependencies.txt \
		license.commercial.txt \
		license.txt \
		structure.txt
}

pkg_postinst() {
	elog "To include getid3 in your code:"
	elog
	elog "    require 'getid3/getid3.php';"
	elog "    require 'getid3/write.php'; // optional, needed for write support"
	elog
	elog "As long as /usr/share/php is set as part of include_path in php.ini."
}
