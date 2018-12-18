# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
if [[ "$PV" = 9999 ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/libimobiledevice/libusbmuxd.git"
	S="${WORKDIR}/${P}"
else
	KEYWORDS="amd64 ~arm ~arm64 ppc ~ppc64 x86"
	MY_HASH="9db5747cd823b1f59794f81560a4af22a031f5c9"
	SRC_URI="https://github.com/libimobiledevice/libusbmuxd/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_HASH}"
fi
inherit autotools "$GIT_ECLASS"

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"

# tools/iproxy.c is GPL-2+, everything else is LGPL-2.1+
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/2" # based on SONAME of libusbmuxd.so
IUSE="kernel_linux static-libs"

RDEPEND=">=app-pda/libplist-1.11:=
	virtual/libusb:1
	!=app-pda/usbmuxd-1.0.9
	!<app-pda/usbmuxd-1.0.8_p1"
DEPEND="${RDEPEND}
	virtual/os-headers
	virtual/pkgconfig"

DOCS=( AUTHORS README )

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=( $(use_enable static-libs static) )
	use kernel_linux || myeconfargs+=( --without-inotify )
	econf ${myeconfargs[*]}
}
