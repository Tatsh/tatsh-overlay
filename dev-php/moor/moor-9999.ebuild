# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2 depend.php

EAPI="3"

DESCRIPTION="A URL Routing/Linking/Controller library for PHP 5.1+."
HOMEPAGE="https://github.com/jeffturcotte/moor"
EGIT_REPO_URI="https://github.com/jeffturcotte/moor.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sutra-patches"

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	if use sutra-patches ; then
		epatch "${FILESDIR}"/${PN}-1.0.0b4-exit-after-dispatch-except-for-post.patch
	fi
}

src_install() {
	mkdir moor
	mv LICENSE *.php *.markdown moor
	insinto /usr/share/php
	doins -r moor
}
