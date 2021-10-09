# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake desktop

DESCRIPTION="Client recreating the functionality of the Sony Headphones app."
HOMEPAGE="https://github.com/Plutoberth/SonyHeadphonesClient"
MY_PN="SonyHeadphonesClient"
MY_SHA="v${PV}"
IMGUI_SHA="fe6369b03dab08c6636e32f57757e72c047e7cf1"
SRC_URI="https://github.com/Plutoberth/SonyHeadphonesClient/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="media-libs/glew:=
	media-libs/glfw
	media-libs/libglvnd
	net-wireless/bluez
	sys-apps/dbus"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}/Client"

src_prepare() {
	rmdir imgui || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" imgui || die
	cmake_src_prepare
}

src_install() {
	cd "${BUILD_DIR}" || die
	dobin "${MY_PN}"
	make_desktop_entry "${MY_PN}" 'Sony Headphones Client' audio-headphones
	einstalldocs
}
