# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit subversion depend.php

DESCRIPTION="A CSS parser and minifier."
HOMEPAGE="http://code.google.com/p/cssmin/"
ESVN_REPO_URI="http://cssmin.googlecode.com/svn/trunk/build"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3"

src_install() {
	insinto /usr/share/php
	doins CssMin.php
}
