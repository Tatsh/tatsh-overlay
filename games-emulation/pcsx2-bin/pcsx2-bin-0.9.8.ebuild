# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils multilib games

DESCRIPTION="A PlayStation 2 emulator."
HOMEPAGE="http://pcsx2.net/"
SRC_URI="http://files.tatsh.net/pcsx2-${PV}-r4594-linux~translation_fix.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-wxGTK-20120505 )
	x86? (
		dev-cpp/sparsehash
		media-libs/libsoundtouch
		media-libs/libsdl
		media-libs/portaudio
		virtual/jpeg
		virtual/glu
		x11-libs/wxGTK
	)
	>=media-gfx/nvidia-cg-toolkit-2.1.0017"

S="${WORKDIR}/pcsx2-0.9.8-r4594-linux"

src_install() {
	local dir=$(get_libdir)

	if use amd64; then
		dir="lib32"
	fi

	dosym libGLEW.so.1.6.0 /usr/${dir}/libGLEW.so.1.5
	dosym libtiff.so.3 /usr/${dir}/libtiff.so.5

	cp docs/pcsx2.man docs/pcsx2.1
	doman docs/pcsx2.1

	insinto /opt/pcsx2
	doins -r *

	exeinto /opt/pcsx2
	doexe pcsx2

	exeinto /usr/games/bin
	doexe "${FILESDIR}/pcsx2"
}
