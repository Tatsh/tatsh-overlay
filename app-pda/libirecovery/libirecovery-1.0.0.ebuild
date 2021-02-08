# Copyright 2018-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="Library and utility to talk to iBoot/iBSS via USB."
HOMEPAGE="https://github.com/libimobiledevice/libirecovery"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

DEPEND="sys-libs/readline
	virtual/libusb:1"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	myconf=$(use_with udev)
	econf "${myconf}"
}
