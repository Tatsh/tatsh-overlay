# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Cross-platform DOS emulation package."
HOMEPAGE="https://dosbox-x.com/"
SRC_URI="https://github.com/joncampbell123/dosbox-x/archive/refs/tags/${PN}-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X +core-inline debug dynrec ffmpeg +fluidsynth +freetype +fpu hardened midi mt-32 opengl printer +screenshots slirp unaligned +xbrz"
REQUIRED_USE="hardened? ( !dynrec )"

DEPEND="debug? ( sys-libs/ncurses:0= )
	ffmpeg? ( media-video/ffmpeg )
	freetype? ( media-libs/freetype )
	fluidsynth? (
		media-sound/fluid-soundfont
		media-sound/fluidsynth
	)
	mt-32? ( media-libs/munt-mt32emu )
	opengl? ( virtual/opengl )
	screenshots? ( media-libs/libpng:0= )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libxkbfile
	)
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/libsdl2[X?]
	media-libs/sdl2-net
	net-libs/libpcap
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/nasm"

PATCHES=(
	"${FILESDIR}/${PN}-fix-rpath.patch"
	"${FILESDIR}/${PN}-invert-1624f04.patch"
)

S="${WORKDIR}/${PN}-${PN}-v${PV}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local fpu_arg='--disable-fpu-x86 --disable-fpu-x64'
	if use fpu; then
		if use x86; then
			fpu_arg=--enable-fpu-x86
		elif use amd64; then
			fpu_arg=--enable-fpu-x64
		fi
	fi
	ac_cv_lib_X11_main=$(usex X yes no) \
	econf \
		$(use_enable !hardened dynamic-core) \
		$(use_enable !hardened dynamic-x86) \
		$(use_enable X x11) \
		$(use_enable core-inline) \
		$(use_enable debug ${debug_arg}) \
		$(use_enable dynrec) \
		$(use_enable ffmpeg avcodec) \
		$(use_enable fluidsynth libfluidsynth) \
		$(use_enable fpu) ${fpu_arg} \
		$(use_enable freetype) \
		$(use_enable midi alsa-midi) \
		$(use_enable mt-32 mt32) \
		$(use_enable opengl) \
		$(use_enable printer) \
		$(use_enable screenshots) \
		$(use_enable slirp libslirp) \
		$(use_enable unaligned unaligned-memory) \
		$(use_enable xbrz) \
		--disable-optimize \
		--enable-sdl2
}
