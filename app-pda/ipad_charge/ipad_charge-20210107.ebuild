# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit udev

DESCRIPTION="Helper utility to enable charging with Apple mobile devices such as the iPad."
HOMEPAGE="https://github.com/mkorenkov/ipad_charge"
SHA="f070404d27affea6963024d852dd2e4941153792"
SRC_URI="https://github.com/mkorenkov/ipad_charge/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -r -e 's/gcc -Wall/$(CC) -Wall $(CFLAGS)/' -i Makefile
	default
}

src_install() {
	dobin ipad_charge
	udev_dorules 95-${PN}.rules
	einstalldocs
}
