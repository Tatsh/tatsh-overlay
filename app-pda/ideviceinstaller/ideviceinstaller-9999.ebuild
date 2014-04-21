# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/usbmuxd/usbmuxd-9999.ebuild,v 1.0 2013/10/31 17:05:12 srcs Exp $

EAPI=5
inherit autotools git-2 udev user

DESCRIPTION="Manage apps of iOS devices."
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.4
	>app-pda/libplist-1.10
	>=dev-libs/libzip-0.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS NEWS README COPYING"

src_prepare() {
	sed -i -e 's:-Werror -g::' configure.ac || die
	eautoreconf
}

# kate: replace-tabs false;
