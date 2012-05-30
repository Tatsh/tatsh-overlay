# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git-2

EAPI=4

DESCRIPTION="Sutra functions."
HOMEPAGE="https://github.com/Tatsh/sutra-functions"
EGIT_REPO_URI="git://github.com/Tatsh/sutra-functions.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/php-5.2.3
dev-php/flourish
dev-php/sutra"

src_prepare() {
	mkdir -p sutra/functions
	mv *.php sutra/functions
}

src_install() {
	insinto /usr/share/php
	doins -r sutra
}
