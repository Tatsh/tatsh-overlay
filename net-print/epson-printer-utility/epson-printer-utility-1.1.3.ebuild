# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop flag-o-matic rpm udev

DESCRIPTION="Epson printer utility for USB only."
HOMEPAGE="https://support.epson.net/linux/Printer/LSB_distribution_pages/en/utility.php"
SRC_URI="https://download3.ebz.epson.net/dsc/f/03/00/15/55/88/b85d1d10a8b0394503bf0ab6b30cb6036f392865/${P}-1.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	virtual/libusb"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	sed -re '/^AM_INIT_AUTOMAKE$/d' -i configure.ac || die
	sed -re 's|x86_64-linux-gnu/qt5|/qt5|g' -i EPSCommonLib/Makefile.am PrinterUtility/Makefile.am || die
	sed -re 's/Application;//' -e 's|/opt/epson-printer-utility/bin/||' -i "${PN}.desktop" || die
	sed -re "s/^Icon=.*/Icon=${PN}/" -i "${PN}.desktop" || die
	eautoreconf
}

src_configure() {
	append-cflags -Wno-narrowing
	append-cxxflags -Wno-narrowing
	default
}

src_install() {
	domenu "${PN}.desktop"
	exeinto "/usr/$(get_libdir)/${PN}"
	doexe "PrinterUtility/${PN}"
	dosym "../$(get_libdir)/${PN}/${PN}" "/bin/${PN}"
	insinto "/usr/$(get_libdir)/${PN}/Images"
	doins PrinterUtility/Images/*
	newicon -s 128 PrinterUtility/Images/AppIcon.png "${PN}.png"
	insinto "/usr/$(get_libdir)/${PN}/Languages"
	doins PrinterUtility/Languages/*.qm
	udev_dorules support-tool/79-udev-epson.rules
}
