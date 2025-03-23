# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Allows you to change the settings of MSI laptops."
HOMEPAGE="https://github.com/dmitry-s93/MControlCenter"
SRC_URI="https://github.com/dmitry-s93/MControlCenter/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-qt/qtbase:6[dbus,network,widgets]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/MControlCenter-${PV}"

src_prepare() {
	sed -re "s|PATHS /lib/qt6/bin/|PATHS /usr/$(get_libdir)/qt6/bin|g" -i CMakeLists.txt || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	mkdir -p "${D}/usr/libexec" || die
	mv "${D}/usr/bin/${PN}-helper" "${D}/usr/libexec" || die
	domenu "resources/${PN}.desktop"
	doicon -s scalable "resources/${PN}.svg"
	insinto /usr/share/dbus-1/system.d
	doins "src/helper/${PN}-helper.conf"
	insinto /usr/share/dbus-1/system-services
	doins "src/helper/${PN}.helper.service"
}
