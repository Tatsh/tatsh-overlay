# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools

DESCRIPTION="Library and utility to talk to iBoot/iBSS via USB."
HOMEPAGE="https://github.com/libimobiledevice/libirecovery"
MY_HASH="4daf6d84f7271cc19256c45b52c63b99ba7b4391"
SRC_URI="https://github.com/libimobiledevice/libirecovery/archive/${MY_HASH}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="udev"

DEPEND="sys-libs/readline
	virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND=""

DOCS=( COPYING README )

S="${WORKDIR}/${PN}-${MY_HASH}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	myconf=$(use_with udev)
	econf "${myconf}"
}
