# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git-2

EAPI=4

DESCRIPTION="An extension upon Flourish."
HOMEPAGE="https://github.com/tatsh/sutra"
EGIT_REPO_URI="git://github.com/tatsh/sutra.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3
				 dev-php/flourish[sutra-patches]"

src_prepare() {
	mv classes sutra
}

src_install() {
	insinto /usr/share/php
	doins -r sutra
}
