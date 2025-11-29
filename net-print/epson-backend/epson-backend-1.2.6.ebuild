# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

DESCRIPTION="Epson CUPS backend (ecbd)."
HOMEPAGE="https://support.epson.net/linux/Printer/LSB_distribution_pages/en/utility.php"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/14/68/96/20259c8247fdde4faa8416ba642825e903f32bb8/epson-printer-utility_arm_source.zip -> ${P}.zip"
S="${WORKDIR}/epson-printer-utility_arm_source"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	virtual/libusb"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${PN}-fixes.patch" )

src_unpack() {
	unpack "${A}"
	unpack "${S}/${PN}-arm-${PV}.tar.gz"
	mv "${PN}-arm-${PV}"/* "${S}" || die
}

src_install() {
	default
	# shellcheck disable=SC2115
	rm -R "${D}/usr/$(get_libdir)/${PN}" "${D}/usr/share/doc" || die
	dodoc "debian/${PN}/usr/share/doc/${PN}/README"
	systemd_newunit "${FILESDIR}/${PN}-ecbd.service" ecbd.service
}
