# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="A PHP class to interact with the Mollom API."
HOMEPAGE="http://mollom.crsolutions.be/"
EGIT_REPO_URI="git://github.com/Tatsh/mollom.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-lang/php-5.2.3"

src_install() {
	insinto /usr/share/php
	doins Mollom.php
}
