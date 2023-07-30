# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Software for the 40Mhz USB-3.0 RF sampler (harrypm fork)."
HOMEPAGE="https://github.com/simoninns/DomesdayDuplicator"
SHA="26032dc9a6c528fe9a96f419e9056aaa83d9626d"
MY_PN="DomesdayDuplicator"
SRC_URI="https://github.com/simoninns/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/qcustomplot
	dev-qt/qtbase:6
	dev-qt/qtserialport:6
	virtual/libusb:1"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${MY_PN}-${SHA}/Linux-Application"

src_configure() {
	local mycmakeargs=( -DUSE_QT_VERSION=6 )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	einstalldocs
	local size
	for size in 128 16 24 256 32 48 64; do
		newicon -s "$size" "${MY_PN}/Graphics/ApplicationIcon/${MY_PN}_${size}x${size}.png" "${PN}.png"
	done
	make_desktop_entry "$MY_PN" "$PN"
}
