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
IUSE="alsa ao evdev openmp pulseaudio ta-lle udev"
REQUIRED_USE="|| ( alsa ao pulseaudio )"

DEPEND="evdev? ( dev-libs/libevdev )
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	pulseaudio? ( media-sound/pulseaudio )
	openmp? ( sys-devel/gcc:=[openmp] )
	udev? ( virtual/udev )
	media-libs/libglvnd
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	virtual/opengl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-emulator-r${PV}"
PATCHES=( "${FILESDIR}/${P}-build-options.patch" )

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA=$(usex alsa)
		-DENABLE_AO=$(usex ao)
		-DENABLE_EVDEV=$(usex evdev)
		-DENABLE_OPENMP=$(usex openmp)
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
		-DENABLE_UDEV=$(usex udev)
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
