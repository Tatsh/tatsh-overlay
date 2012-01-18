# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion depend.php

EAPI=3

DESCRIPTION="A PHP un-framework focusing on solving problems intrinsic to web development."
HOMEPAGE="http://flourishlib.com/"
ESVN_REPO_URI="http://svn.flourishlib.com/trunk/classes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

src_install() {
	mkdir flourish
	mv *.php *.rev flourish
	insinto /usr/share/php
	doins -r flourish
}
