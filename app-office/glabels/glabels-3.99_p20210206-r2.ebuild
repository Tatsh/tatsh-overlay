# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="glabels label designer (now in Qt)."
HOMEPAGE="https://github.com/jimevins/glabels-qt"
MY_PV="${PV%_*}-master564"
SRC_URI="https://github.com/jimevins/${PN}-qt/archive/refs/tags/${PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="barcode qrcode zlib"

DEPEND="zlib? ( sys-libs/zlib )
	barcode? ( app-text/barcode )
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtxml:5
	dev-qt/qtsvg:5
	dev-qt/qtgui:5"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/linguist-tools:5"

S="${WORKDIR}/${PN}-qt-${PN}-${MY_PV}"

src_prepare() {
	sed -r -e '/find_package \(Qt5Test.*/d' \
		-e '/find_package \(LibZint.*/d' \
		-i CMakeLists.txt || die
	! use zlib && { sed -r -e '/find_package \(ZLIB.*/d' -i CMakeLists.txt || die; }
	! use barcode && { sed -r -e '/find_package \(GnuBarcode.*/d' -i CMakeLists.txt || die; }
	! use qrcode && { sed -r -e '/find_package \(LibQrencode.*/d' -i CMakeLists.txt || die; }
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	rm -R "${D}/usr/share/appdata" || die
	einstalldocs
}
