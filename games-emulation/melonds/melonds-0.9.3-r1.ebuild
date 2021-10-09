# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="A fast and accurate Nintendo DS emulator."
HOMEPAGE="http://melonds.kuribo64.net/"
SRC_URI="https://github.com/Arisotura/melonDS/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="app-arch/libarchive
	dev-libs/teakra
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtwidgets
	media-libs/libepoxy
	media-libs/libsdl2
	net-libs/libslirp"
RDEPEND="${DEPEND}"

S="${WORKDIR}/melonDS-${PV}"

src_prepare() {
	sed -e 's/^Exec=.*/Exec=env -u QT_SCREEN_SCALE_FACTORS melonDS/' -i net.kuribo64.melonDS.desktop
	cmake_src_prepare
}
