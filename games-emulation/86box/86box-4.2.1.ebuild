# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Emulator of x86-based machines based on PCem."
HOMEPAGE="https://github.com/86Box/86Box"
SRC_URI="https://github.com/86Box/86Box/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dynrec +fluidsynth mt-32 new-dynrec openal"

DEPEND="app-emulation/faudio
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/libpng
	media-libs/libsdl2[X,opengl]
	openal? ( media-libs/openal )
	media-libs/libsndfile
	>media-libs/rtmidi-4.1.0
	net-libs/libslirp
	dev-libs/libevdev
	dev-libs/wayland
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	x11-libs/libxkbcommon
	x11-libs/libX11
	x11-libs/libXi"
RDEPEND="${DEPEND}"

S="${WORKDIR}/86Box-${PV}"

src_configure() {
	local mycmakeargs=(
		-DDEV_BRANCH=ON
		"-DDYNAREC=$(usex dynrec)"
		"-DFLUIDSYNTH=$(usex fluidsynth)"
		-DMINITRACE=OFF
		"-DMUNT=$(usex mt-32)"
		"-DNEW_DYNAREC=$(usex new-dynrec)"
		"-DOPENAL=$(usex openal)"
		-DRELEASE=ON
		-DSLIRP_EXTERNAL=ON
		# Does not work on non-Windows. Attempts to link with ws2_32
		-DVNC=OFF
	)
	cmake_src_configure
}
