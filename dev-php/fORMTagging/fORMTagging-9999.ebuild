# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="Flourish ORM plugin for tagging."
HOMEPAGE="https://github.com/tatsh/fpORMTagging"
EGIT_REPO_URI="git://github.com/tatsh/fpORMTagging.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2.3
	dev-php/flourish"

src_install() {
	insinto /usr/share/php/flourish
	doins -r fORMTagging.php
	dodoc README
}

pkg_postinst() {
	elog
	elog "To use, include flourish/fORMTagging.php after including dependencies"
	elog
	elog "  require 'flourish/fLoader.php';"
	elog "  require 'flourish/fORMTagging.php';"
	elog
}
