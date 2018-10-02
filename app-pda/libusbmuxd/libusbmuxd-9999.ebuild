# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
EGIT_REPO_URI="https://github.com/libimobiledevice/libusbmuxd.git"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/2" # based on SONAME of libusbmuxd.so
KEYWORDS="amd64 ~arm ~arm64 ppc ~ppc64 x86"
IUSE="kernel_linux static-libs"

RDEPEND=">=app-pda/libplist-1.11:=
	virtual/libusb:1
	!=app-pda/usbmuxd-1.0.9
	!<app-pda/usbmuxd-1.0.8_p1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

DOCS=( AUTHORS README )

S="${WORKDIR}/${P}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )
	econf ${myeconfargs[*]}
}
