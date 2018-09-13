# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Sega Dreamcast emulator."
HOMEPAGE="http://reicast.com/"
SRC_URI="https://github.com/${PN}/${PN}-emulator/archive/r${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa ao +evdev joystick pulseaudio"

# FIXME Eventually use system libpng, libwebsocket, libzip, zlib,
# nettle (crypto)
# https://github.com/reicast/reicast-emulator/tree/master/core/deps
DEPEND=">=dev-python/python-evdev-0.6.1
	>=media-libs/alsa-lib-1.0.29
	>=x11-base/xorg-server-1.12.4-r5
	ao? ( media-libs/libao )
	pulseaudio? ( media-sound/pulseaudio )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-emulator-r${PV}"

src_prepare () {
	default
	! use alsa && sed -e '/^USE_ALSA.*/d' -i shell/linux/Makefile
	! use evdev && sed -e '/^USE_EVDEV.*/d' -i shell/linux/Makefile
	! use joystick && sed -e '/^USE_JOYSTICK.*/d' -i shell/linux/Makefile
	use ao && sed -e '/^#USE_LIBAO.*/USE_LIBAO = 1' -i shell/linux/Makefile
	use pulseaudio && sed -e '/^#USE_PULSEAUDIO/USE_PULSEAUDIO = 1/' \
		-i shell/linux/Makefile
	sed -e '/^USE_OSS.*/d' -i shell/linux/Makefile
	sed -e "s/^LDFLAGS :=.*/LDFLAGS := $LDFLAGS/" -i shell/linux/Makefile
	sed -e "s/^CFLAGS :=.*/CFLAGS := $CFLAGS/" -i shell/linux/Makefile
	sed -e "s/^CXXFLAGS :=.*/CXXFLAGS := $CXXFLAGS/" -i shell/linux/Makefile
	sed -e 's/^CFLAGS += -g -O3/CFLAGS += /' -i shell/linux/Makefile
	sed -e 's/^LDFLAGS += -g/LDFLAGS += /' -i shell/linux/Makefile
	sed -e 's/-Wl,-O3//g' -i shell/linux/Makefile
}

src_compile () {
	local platform=x86
	use amd64 && platform=x64
	emake -C shell/linux "platform=${platform}"
}

src_install () {
	ls
	emake -C shell/linux PREFIX="${D}/usr" install
}
