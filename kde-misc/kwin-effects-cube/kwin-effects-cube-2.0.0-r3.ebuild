# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Desktop cube effect for Kwin."
HOMEPAGE="https://github.com/zzag/kwin-effects-cube"
SRC_URI="https://github.com/zzag/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquick3d:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtwidgets:5
	kde-frameworks/kconfig:5
	kde-frameworks/kconfigwidgets:5
	kde-frameworks/kcoreaddons:5
	kde-frameworks/kglobalaccel:5
	kde-frameworks/ki18n:5
	kde-frameworks/kwindowsystem:5
	kde-frameworks/kxmlgui:5
	media-libs/libepoxy
	kde-plasma/kwin
	x11-libs/libxcb"
RDEPEND="${DEPEND}"
BDEPEND="dev-build/cmake
	kde-frameworks/extra-cmake-modules"

src_prepare() {
	sed -re 's/kwin4/kwin/g' -i src/CMakeLists.txt || die
	cmake_src_prepare
}

pkg_postinst() {
	einfo
	einfo 'You will likely need to restart Kwin for this option to display. Perform the following'
	einfo 'in a new terminal or reboot your system:'
	einfo
	einfo '  kwin_x11 --replace &'
	einfo
}
