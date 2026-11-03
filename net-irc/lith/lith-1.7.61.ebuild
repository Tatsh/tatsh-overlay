# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Multiplatform, mobile-focused WeeChat relay client"
HOMEPAGE="https://github.com/LithApp/lith"
SRC_URI="https://github.com/LithApp/lith/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Lith-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/qcoro
	dev-libs/qtkeychain:=
	dev-qt/qtbase:6[dbus,gui,network,widgets,xml]
	dev-qt/qtdeclarative:6
	dev-qt/qtmultimedia:6
	dev-qt/qtwebsockets:6"
RDEPEND="${DEPEND}"

src_configure() {
	# Release archives must not pick up the overlay checkout's Git metadata.
	local -x GIT_CEILING_DIRECTORIES="${WORKDIR}"
	local mycmakeargs=(
		"-DLITH_VERSION=${PV}"
		-DLITH_FEATURE_KEYCHAIN=ON
		-DLITH_FORCE_LOCAL_PACKAGES_ONLY=ON
		-Wno-dev
	)
	cmake_src_configure
}
