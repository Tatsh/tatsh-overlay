# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils git-2

EAPI=4

DESCRIPTION="PHPMD Rule set specific to Sutra and related projects."
HOMEPAGE="https://github.com/Tatsh/sutra-pmd-rules"
EGIT_REPO_URI="git://github.com/Tatsh/sutra-pmd-rules.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=">=dev-php/phpmd-1.1.0"

src_install() {
	insinto /usr/share/php
	doins -r PHP data
}
