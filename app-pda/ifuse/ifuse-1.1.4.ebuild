# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/usbmuxd/usbmuxd-9999.ebuild,v 1.0 2013/10/31 17:05:12 srcs Exp $

EAPI=7

KEYWORDS="amd64 x86"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${PV}/${P}.tar.bz2"
inherit autotools udev user "$GIT_ECLASS"

DESCRIPTION="A fuse filesystem implementation to access the contents of iOS devices."
HOMEPAGE="http://www.libimobiledevice.org/"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=app-pda/libimobiledevice-1.1.6
	>app-pda/libplist-1.10
	>=sys-fs/fuse-2.7.0
	virtual/libusb:1
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
	default
}

pkg_postinst() {
	ewarn "Only use this filesystem driver to create backups of your data."
	ewarn "The music database is hashed, and attempting to add files will "
	ewarn "cause the iPod/iPhone to consider your database unauthorised."
	ewarn "It will respond by wiping all media files, requiring a restore "
	ewarn "through iTunes. You have been warned."
}

# kate: replace-tabs false;
