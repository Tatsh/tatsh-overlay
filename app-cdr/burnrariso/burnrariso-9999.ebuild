# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git-2

EAPI="3"

DESCRIPTION="Burn an ISO out of a set of RARs."
HOMEPAGE="https://github.com/tatsh/misc-scripts"
EGIT_REPO_URI="git://github.com/tatsh/misc-scripts.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-arch/unrar
	>=app-arch/cksfv-1.3.12
	>=app-cdr/cdrkit-1.1.11
"

src_install() {
	dobin burnrariso
}
