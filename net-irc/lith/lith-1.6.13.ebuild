# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Emulator of x86-based machines based on PCem."
HOMEPAGE="https://github.com/LithApp/lith"
SRC_URI="https://github.com/LithApp/lith/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/qcoro
	dev-libs/qtkeychain
	dev-qt/qtbase:6[dbus,gui,network,widgets,xml]
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	dev-qt/qtwebsockets:6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Lith-${PV}"

src_configure() {
	local mycmakeargs=(
		"-DVERSION=${PV}"
		-DLITH_FEATURE_KEYCHAIN=ON
		-DLITH_FORCE_LOCAL_PACKAGES_ONLY=ON
		-Wno-dev
	)
	cmake_src_configure
}
