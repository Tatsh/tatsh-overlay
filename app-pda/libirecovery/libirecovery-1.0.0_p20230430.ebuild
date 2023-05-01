# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="Library and utility to talk to iBoot/iBSS via USB."
HOMEPAGE="https://github.com/libimobiledevice/libirecovery"
SHA="1d20bed9ab853507b013e0ab0fdfa11be393d1e0"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="udev"

DEPEND=">=app-pda/libimobiledevice-glue-1.0.0:=
	>=app-pda/libplist-2.3.0:=
	sys-libs/readline
	virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	myconf=$(use_with udev)
	econf "${myconf}"
}

src_install() {
	default
	rm "${D}/usr/$(get_libdir)/${PN}-1.0.la" || die
}
