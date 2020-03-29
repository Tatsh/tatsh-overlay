# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The dreaded beachball."
HOMEPAGE="https://store.kde.org/p/999971/"
SRC_URI="57588-Shere_Khan_X.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"
S="${WORKDIR}/Shere_Khan_X"

fetch() {
	einfo "Please download 57588-Shere_Khan_X.tar.gz and move it to"
	einfo "your distfiles directory:"
	einfo
	einfo "  https://store.kde.org/p/999971/"
}

src_install() {
	insinto /usr/share/cursors/xorg-x11/Shere_Khan_X/cursors/
	doins cursors/*
}
