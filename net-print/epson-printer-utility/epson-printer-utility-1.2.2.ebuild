# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop rpm systemd udev

DESCRIPTION="Epson printer utility for USB only."
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/16/74/31/d573ccb040f3e36459f633c5df719999d0fe81ac/${P}-1.x86_64.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	virtual/libusb"

S="${WORKDIR}"

src_prepare() {
	default
	mv usr/share/doc/README . || die
	rm -fR usr/share || die
	mv "opt/${PN}/${PN}.desktop" "opt/${PN}/rules/79-udev-epson.rules" \
		usr/lib/epson-backend/ecbd.service . || die
	rm -fR "opt/${PN}/rules" || die
}

src_install() {
	domenu "${PN}.desktop"
	dodoc README
	udev_dorules 79-udev-epson.rules
	systemd_dounit ecbd.service
	rm ecbd.service 79-udev-epson.rules "${PN}.desktop" README || die
	doins -r .
}
