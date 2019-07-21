# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-pda/usbmuxd/usbmuxd-9999.ebuild,v 1.0 2013/10/31 17:05:12 srcs Exp $

EAPI=7
if [[ "$PV" = 9999 ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/libimobiledevice/usbmuxd.git"
else
	KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
	MY_HASH="96e4aabe0b9a46ea9da4955a10c774a8e58fe677"
	SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_HASH}"
fi
inherit autotools udev user "$GIT_ECLASS"

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"

LICENSE="GPL-2 GPL-3"
SLOT="0"
IUSE="udev +worker"

RDEPEND=">=app-pda/libplist-1.9
	virtual/libusb:1
	acct-group/plugdev
	acct-user/usbmux"
DEPEND="${RDEPEND}
	worker? ( >=app-pda/libusbmuxd-1.0.9 )
	>=app-pda/libimobiledevice-1.1.6
	virtual/pkgconfig"

DOCS=( AUTHORS README )

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf
	use worker || myconf='--without-preflight'

	econf ${myconf}
}

src_install() {
	default

	if ! use udev; then
		rm "${ED}"/$(get_udevdir)/rules.d/39-usbmuxd.rules
		rmdir -p "${ED}"/$(get_udevdir)/rules.d
	fi
}
