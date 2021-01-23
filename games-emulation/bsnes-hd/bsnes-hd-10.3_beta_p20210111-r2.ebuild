# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop toolchain-funcs xdg-utils

DESCRIPTION="bsnes fork that adds HD video features."
HOMEPAGE="https://github.com/DerKoun/bsnes-hd"
MY_SHA="ad7a9ef0cbfe66466289bb8d62d6a4885af209d5"
BIN_PN="${PN%-*}"
SRC_URI="https://github.com/DerKoun/bsnes-hd/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao +alsa openal opengl oss pulseaudio +sdl udev xv"
REQUIRED_USE="|| ( ao openal alsa pulseaudio oss )
	|| ( xv opengl sdl )"

DEPEND="x11-libs/gtk+:2
	x11-libs/gtksourceview:2.0
	x11-libs/libX11
	x11-libs/libXext
	ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	xv? ( x11-libs/libXv )
	opengl? ( virtual/opengl )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl[X,joystick,video] )
	udev? ( virtual/udev )"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

disable_module() {
	sed -i \
		-e "s|$1\b||" \
		"${S}"/${BIN_PN}/target-${BIN_PN}/GNUmakefile || die
}

src_prepare() {
	default
	sed -i \
		-e "/handle/s#/usr/local/lib#/usr/$(get_libdir)#" \
		nall/dl.hpp || die "fixing libdir failed!"
	# audio modules
	use ao || disable_module audio.ao
	use openal || disable_module audio.openal
	use pulseaudio ||  { disable_module audio.pulseaudio
			disable_module audio.pulseaudiosimple ;}
	use oss || disable_module audio.oss
	use alsa || disable_module audio.alsa
	# video modules
	use opengl || disable_module video.glx
	use xv || disable_module video.xvideo
	use sdl || disable_module video.sdl
	# input modules
	use sdl || disable_module input.sdl
	use udev || disable_module input.udev
}

src_compile() {
	# Needed for fluent audio (even on i5 hardware)
	export CFLAGS="${CFLAGS} -O3"
	export CXXFLAGS="${CXXFLAGS} -O3"
	emake -C "${BIN_PN}" \
		"compiler=$(tc-getCXX)"
}

src_install() {
	newbin "${S}"/${BIN_PN}/out/${BIN_PN} ${PN}
	make_desktop_entry "${PN}" "${PN}"
	newicon -s 256 ${BIN_PN}/target-${BIN_PN}/resource/${BIN_PN}.png ${PN}.png
	newicon ${BIN_PN}/target-${BIN_PN}/resource/${BIN_PN}.svg ${PN}.svg
	einstalldocs
}

pkg_preinst() {
	games_pkg_preinst
}

pkg_postrm() {
	xdg_icon_cache_update
}

pkg_postinst() {
	xdg_icon_cache_update
}
