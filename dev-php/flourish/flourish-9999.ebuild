# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

EAPI=3

DESCRIPTION="A PHP un-framework focusing on solving problems intrinsic to web development."
HOMEPAGE="http://flourishlib.com/"
ESVN_REPO_URI="http://svn.flourishlib.com/trunk/classes"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="sutra-patches"

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir flourish
	mv *.php *.rev flourish

	if use sutra-patches ; then
		epatch "${FILESDIR}"/${PN}-r1041-fhtml-allow-dashes-in-attributes.patch
		epatch "${FILESDIR}"/${PN}-r1041-ignore-warning-sortbycallback.patch
		epatch "${FILESDIR}"/${PN}-r1041-protected-determineprocessor.patch
		epatch "${FILESDIR}"/${PN}-r1042-add-minifyjavascript-static-method.patch
		epatch "${FILESDIR}"/${PN}-r1042-tsvector-pgsql.patch
		epatch "${FILESDIR}"/${PN}-r1042-fupload-size-var.patch
	fi
}

src_install() {
	insinto /usr/share/php
	doins -r flourish
}
