# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="A PHP class to interact with the Facebook API."
HOMEPAGE="https://github.com/facebook/facebook-php-sdk"
EGIT_REPO_URI="git://github.com/facebook/facebook-php-sdk.git"
EGIT_COMMIT="6c82b3fdfb8efd27751de028d75fd3ab1f2c1ade"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-lang/php-5.2.3"

src_prepare() {
	mkdir facebook
	cp src/*.php *.md facebook
}

src_install() {
	insinto /usr/share/php
	doins -r facebook
}
