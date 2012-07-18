# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="Symfony 2 coding standards for PHP CodeSniffer."
HOMEPAGE="https://github.com/opensky/Symfony2-coding-standard"
EGIT_REPO_URI="git://github.com/opensky/Symfony2-coding-standard.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3
dev-php/PEAR-PHP_CodeSniffer"

src_prepare() {
	mkdir Symfony2
	cp -R Docs \
		Sniffs \
		Tests \
		ruleset.xml \
			Symfony2
}

src_install() {
	insinto /usr/share/php/PHP/CodeSniffer/Standards
	doins -r Symfony2
}
