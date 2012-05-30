# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="PHP's ucwords() for shell."
HOMEPAGE="https://github.com/Tatsh/misc-scripts"
EGIT_REPO_URI="git://github.com/Tatsh/misc-scripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
>=dev-lang/php-5.2.3"

src_install() {
	dobin ucwords
}
