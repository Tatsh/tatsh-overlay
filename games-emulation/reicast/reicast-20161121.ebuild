# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit git-r3

DESCRIPTION="Sega Dreamcast emulator."
HOMEPAGE="http://reicast.com/"
EGIT_REPO_URI="https://github.com/reicast/reicast-emulator.git"
EGIT_COMMIT="aca9cb6919206ef104f4827e04106a1312f0ab71"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +evdev joystick oss"

DEPEND=">=dev-python/python-evdev-0.6.1
	>=media-libs/alsa-lib-1.0.29
	>=x11-base/xorg-server-1.12.4-r5"
RDEPEND="${DEPEND}"

src_prepare () {
	default
	! use alsa && sed -e '/^USE_ALSA.*/d' -i shell/linux/Makefile
	! use evdev && sed -e '/^USE_EVDEV.*/d' -i shell/linux/Makefile
	! use joystick && sed -e '/^USE_JOYSTICK.*/d' -i shell/linux/Makefile
	! use oss && sed -e '/^USE_OSS.*/d' -i shell/linux/Makefile
	sed -e "s/^LDFLAGS :=.*/LDFLAGS := $LDFLAGS/" -i shell/linux/Makefile
	sed -e "s/^CFLAGS :=.*/CFLAGS := $CFLAGS/" -i shell/linux/Makefile
	sed -e "s/^CXXFLAGS :=.*/CXXFLAGS := $CXXFLAGS/" -i shell/linux/Makefile
}

src_compile () {
	emake -C shell/linux
}

src_install () {
	emake -C shell/linux PREFIX="${D}/usr" install
}
