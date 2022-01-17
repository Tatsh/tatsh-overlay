# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Emulator of x86-based machines based on PCem."
HOMEPAGE="https://github.com/86Box/86Box"
SHA="939a7018366aa940cc2565bd018050cfab90a3d2"
SRC_URI="https://github.com/86Box/86Box/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+dynrec +fluidsynth mt-32 new-dynrec usb vramdump"

DEPEND="media-libs/alsa-lib
	media-libs/freetype
	media-libs/libpng
	media-libs/libsdl2[X,opengl]
	media-libs/openal
	>media-libs/rtmidi-4.0.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/86Box-${SHA}"

src_configure() {
	local mycmakeargs=(
		-DDEV_BRANCH=ON
		-DDYNAREC=$(usex dynrec)
		-DFLUIDSYNTH=$(usex fluidsynth)
		-DMINITRACE=OFF
		-DMUNT=$(usex mt-32)
		-DNEW_DYNAREC=$(usex new-dynrec)
		-DRELEASE=ON
		-DUSB=$(usex usb)
		-DVRAMDUMP=$(usex vramdump)
		# Does not work on non-Windows. Attempts to link with ws2_32
		-DVNC=OFF
	)
	cmake_src_configure
}
