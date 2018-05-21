# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 linux-mod udev

DESCRIPTION="Linux driver for the Retro-bit controller adapter USB cable"
HOMEPAGE="https://github.com/retuxx/hid-retrobit"
EGIT_REPO_URI="https://github.com/retuxx/hid-retrobit.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	virtual/udev"

CONFIG_CHECK="HID HID_GENERIC"
MODULE_NAMES="hid-retrobit(usb:${S}:${S})"
BUILD_TARGETS="clean all"

src_prepare() {
	sed -e '2s/ccflags.*//' -i Makefile || die
}

src_compile() {
	KDIR="/lib/modules/${KV_FULL}/build" linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	udev_dorules 99-hid-retrobit.rules
	udev_reload

	insinto /etc/modules-load.d/
	doins hid-retrobit.conf
}
