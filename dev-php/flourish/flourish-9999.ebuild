# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit git-2 eutils

DESCRIPTION="A PHP un-framework focusing on solving problems intrinsic to web development."
HOMEPAGE="https://github.com/Tatsh/flourish-classes"
EGIT_REPO_URI="git://github.com/Tatsh/flourish-classes.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/php-5.2.3"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir flourish
	mv *.php *.rev flourish

	epatch "${FILESDIR}"/${PN}-r1041-ignore-warning-sortbycallback.patch
	epatch "${FILESDIR}"/${PN}-r1042-tsvector-pgsql.patch
}

src_install() {
	insinto /usr/share/php
	doins -r flourish
}
