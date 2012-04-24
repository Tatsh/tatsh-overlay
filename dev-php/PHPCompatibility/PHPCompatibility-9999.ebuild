# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="PHP Compatibility check for PHP_CodeSniffer."
HOMEPAGE="http://techblog.wimgodden.be/tag/codesniffer"
EGIT_REPO_URI="git://github.com/tatsh/PHPCompatibility.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2.3
	>=dev-php/PEAR-PHP_CodeSniffer-1.3.3"

src_prepare() {
	mkdir PHPCompatibility
	cp -R Sniffs ruleset.xml PHPCompatibility
}

src_install() {
	insinto /usr/share/php/PHP/CodeSniffer/Standards
	doins -r PHPCompatibility
	dodoc README
}
