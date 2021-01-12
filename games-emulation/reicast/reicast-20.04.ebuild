# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake desktop

DESCRIPTION="Sega Dreamcast emulator."
HOMEPAGE="http://reicast.com/"
SRC_URI="https://github.com/${PN}/${PN}-emulator/archive/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa ao curl evdev openmp pulseaudio ta-lle"
REQUIRED_USE="|| ( alsa ao pulseaudio )"

DEPEND="evdev? ( dev-libs/libevdev )
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	pulseaudio? ( media-sound/pulseaudio )
	curl? ( net-misc/curl )
	openmp? ( sys-devel/gcc:=[openmp] )
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	virtual/opengl
	virtual/udev"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-emulator-r${PV}"

src_prepare() {
	{ use evdev || sed -e 's:if(LIBEVDEV_FOUND):if(FALSE):' -i CMakeLists.txt; } || die
	{ use ao || sed -e 's:if(AO_FOUND):if(FALSE):' -i CMakeLists.txt; } || die
	{ use pulseaudio || sed -e 's:if(LIBPULSE_SIMPLE_FOUND):if(FALSE):' -i CMakeLists.txt; } || die
	{ use curl || sed -e 's:IF(CURL_FOUND):if(FALSE):' -i CMakeLists.txt; } || die
	{ use openmp || sed -e 's:if(OpenMP_FOUND):if(FALSE):' -i CMakeLists.txt; } || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DHAS_TA_LLE=$(usex ta-lle)
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/${PN}"
	einstalldocs
	doman ${PN}/linux/man/*.1
	newbin ${PN}/linux/tools/${PN}-joyconfig.py ${PN}-joyconfig
	doicon ${PN}/linux/${PN}.png
	insinto /usr/share/${PN}/mappings
	doins ${PN}/linux/mappings/*.cfg
}
