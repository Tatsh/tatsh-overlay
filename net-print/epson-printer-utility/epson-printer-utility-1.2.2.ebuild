# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop systemd udev unpacker

DESCRIPTION="Epson printer utility for USB only."
HOMEPAGE="https://download-center.epson.com/softwares/?device_id=XP-7100+Series&region=US&os=DEBX64&language=en"
SRC_URI="https://download-center.epson.com/f/module/3a44298f-8898-4a4d-8928-48211a1a9657/${PN}_${PV}-1_amd64.deb"
S="${WORKDIR}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	virtual/libusb"

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
