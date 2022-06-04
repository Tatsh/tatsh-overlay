# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake desktop

DESCRIPTION="Client recreating the functionality of the Sony Headphones app."
HOMEPAGE="https://github.com/Plutoberth/SonyHeadphonesClient"
MY_PN="SonyHeadphonesClient"
SHA="bba9e504e499e61cffc5405540dec9b06e7459fb"
SRC_URI="https://github.com/Plutoberth/SonyHeadphonesClient/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

DEPEND="dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	net-wireless/bluez
	sys-apps/dbus
	sys-libs/libunwind"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${SHA}/Client"
BUILD_DIR="${S}/build"

src_install() {
	cd "${BUILD_DIR}" || die
	dobin "${MY_PN}"
	make_desktop_entry "${MY_PN}" 'Sony Headphones Client' audio-headphones
	einstalldocs
}
