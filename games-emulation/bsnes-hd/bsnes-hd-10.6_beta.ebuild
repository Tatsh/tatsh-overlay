#1 Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs

DESCRIPTION="bsnes fork that adds HD video features."
HOMEPAGE="https://github.com/DerKoun/bsnes-hd"
MY_MAJOR="${PV%.*}"
MY_MINOR="${PV#*.}"
MY_MINOR="${MY_MINOR%_*}"
SHA="f46b6d6368ea93943a30b5d4e79e8ed51c2da5e8"
BIN_PN="${PN%-*}"
SRC_URI="https://github.com/DerKoun/bsnes-hd/archive/${SHA}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="ao +alsa libretro openal opengl oss pulseaudio +sdl udev xv"
REQUIRED_USE="|| ( ao openal alsa pulseaudio oss )
	|| ( xv opengl sdl )"

DEPEND="dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libsdl2
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/pango
	ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	alsa? ( media-libs/alsa-lib )
	xv? ( x11-libs/libXv )
	opengl? ( media-libs/libglvnd[X] )
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl[X,joystick,video] )
	udev? ( virtual/udev )"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-102.patch"
	"${FILESDIR}/${PN}-114.patch"
	"${FILESDIR}/${PN}-116.patch"
	"${FILESDIR}/${PN}-gdk-backend.patch"
)

disable_module() {
	sed -i -e "s|$1\b||" ruby/GNUmakefile || die
}

src_prepare() {
	sed -i \
		-e "/handle/s#/usr/local/lib#/usr/$(get_libdir)#" \
		nall/dl.hpp || die "fixing libdir failed!"
	# audio modules
	use alsa || disable_module audio.alsa
	use ao || disable_module audio.ao
	use openal || disable_module audio.openal
	use pulseaudio || { disable_module audio.pulseaudio && disable_module audio.pulseaudiosimple; }
	use oss || disable_module audio.oss
	# video modules
	use opengl || { disable_module video.glx && disable_module video.glx2; }
	use xv || disable_module video.xvideo
	use sdl || disable_module video.sdl
	# input modules
	use sdl || disable_module input.sdl
	use udev || disable_module input.udev
	default
}

src_compile() {
	# Needed for fluent audio (even on i5 hardware)
	export CFLAGS="${CFLAGS} -O3"
	export CXXFLAGS="${CXXFLAGS} -O3"
	emake -C "${BIN_PN}" "compiler=$(tc-getCXX)" hiro=gtk3
	mkdir saved || die
	cp "${BIN_PN}/out/${BIN_PN}" saved/ || die
	if use libretro; then
		emake -C "${BIN_PN}" clean
		emake -C "${BIN_PN}" \
			target=libretro \
			binary=library \
			"compiler=$(tc-getCXX)"
	fi
}

src_install() {
	if use libretro; then
		insinto "/usr/$(get_libdir)/libretro"
		doins "${BIN_PN}/out/${PN/-/_}_beta_libretro.so"
	fi
	newbin "saved/${BIN_PN}" "${PN}"
	make_desktop_entry "${PN}" "${PN}"
	newicon -s 256 "${BIN_PN}/target-${BIN_PN}/resource/${BIN_PN}.png" "${PN}.png"
	newicon "${BIN_PN}/target-${BIN_PN}/resource/${BIN_PN}.svg" "${PN}.svg"
	einstalldocs
}
