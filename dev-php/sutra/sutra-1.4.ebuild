# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="An extension upon Flourish."
HOMEPAGE="https://github.com/Tatsh/sutra"
EGIT_REPO_URI="git://github.com/Tatsh/sutra.git"
EGIT_COMMIT="09d6c5199eee443a945a4243092be14d3d00ae59"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3
dev-php/flourish"

src_prepare() {
	mv classes sutra
	mv functions sutra
}

src_install() {
	insinto /usr/share/php
	doins -r sutra
}
