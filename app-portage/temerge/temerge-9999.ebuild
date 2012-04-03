# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="Wrapper for emerge that uses tmpfs for emerging."
HOMEPAGE="https://github.com/tatsh/misc-scripts"
EGIT_REPO_URI="git://github.com/tatsh/misc-scripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin temerge
}
