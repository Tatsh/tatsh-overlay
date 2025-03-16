# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="ASIO to JACK driver for Wine."
HOMEPAGE="https://github.com/wineasio/wineasio"
RTAUDIO_SHA="e03448bd15c1c34e842459939d755f5f89e880ed"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.gz
	https://github.com/falkTX/rtaudio/archive/${RTAUDIO_SHA}.tar.gz -> ${P}-rtaudio-${RTAUDIO_SHA}.tar.gz"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jack
	virtual/wine"

src_prepare() {
	rm -fR rtaudio || die
	mv "${WORKDIR}/rtaudio-${RTAUDIO_SHA}" rtaudio || die
	sed -re "s/CC.* = gcc$/CC = $(tc-getCC)/" -i Makefile.mk || die
	default
}

src_compile() {
	filter-lto
	emake "VERSION=${PV}" "PREFIX=${EPREFIX}/usr" 32 64
}

src_install() {
	dobin "${PN}-register"
	insinto /usr/lib/wine/i386-windows
	doins "build32/${PN}32.dll"
	exeinto /usr/lib/wine/i386-unix
	doexe "build32/${PN}32.dll.so"
	insinto /usr/lib/wine/x86_64-windows
	doins "build64/${PN}64.dll"
	exeinto /usr/lib/wine/x86_64-unix
	doexe "build64/${PN}64.dll.so"
}
