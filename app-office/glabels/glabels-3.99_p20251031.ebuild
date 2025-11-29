# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="glabels label designer (now in Qt)."
HOMEPAGE="https://github.com/j-evins/glabels-qt"
SHA="e5be07101b0f14285b08038f6f2bad0f79bc9a27"
SRC_URI="https://github.com/j-evins/${PN}-qt/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-qt-${SHA}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="barcode qrcode zlib"

DEPEND="zlib? ( virtual/zlib )
	barcode? ( app-text/barcode )
	dev-qt/qtbase:6[cups,gui,widgets,xml]
	dev-qt/qtsvg:6"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]"

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
