# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="A URL Routing/Linking/Controller library for PHP 5.1+ (tatsh fork)."
HOMEPAGE="https://github.com/tatsh/moor"
EGIT_REPO_URI="git://github.com/tatsh/moor.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-lang/php-5.2.3"

src_install() {
	mkdir moor
	mv LICENSE *.php *.markdown moor
	insinto /usr/share/php
	doins -r moor
}
