# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake autotools eutils desktop

DESCRIPTION="Advanced rhythm game. Designed for both home and arcade use"
MY_SHA="8ae4beb2d4313e22b2cd3a0bcf0d893e6df8f7c4"
HOMEPAGE="http://www.stepmania.com/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa +crash-handler debug +gles2 +gpl +gtk +jpeg +mp3 +networking +ogg
	+wav +xinerama +sdl +xrandr +X +bundled-songs +bundled-courses lto minimaid
	parallel-port profiling pulseaudio jack"

DEPEND="x11-libs/gtk+:2
	alsa? ( media-libs/alsa-lib )
	mp3? ( media-libs/libmad )
	ogg? ( media-libs/libogg media-libs/libvorbis )
	pulseaudio? ( media-sound/pulseaudio )
	media-libs/libpng
	jpeg? ( virtual/jpeg )
	xinerama? ( x11-libs/libXinerama )
	sdl? ( media-libs/libsdl2 )
	>=media-video/ffmpeg-4.2.4
	media-libs/glew
	xrandr? ( x11-libs/libXrandr )
	X? ( x11-libs/libX11 )
	jack? ( virtual/jack )
	virtual/opengl"

S="${WORKDIR}/${PN}-${MY_SHA}"
CMAKE_MAKEFILE_GENERATOR=ninja

src_prepare() {
	einfo 'Removing useless instructions.txt files ...'
	find . -type f -iname 'instructions.txt' -exec rm -f {} \;

	einfo 'Removing useless _assets directory ...'
	rm -fR _assets

	# Built-in songs and courses
	if ! use bundled-courses; then
		einfo 'Removing bundled courses'
		rm -rf "${S}/Courses/Default"
	fi
	if ! use bundled-songs; then
		einfo 'Removing bundled songs'
		rm -rf "${S}/Songs/StepMania 5"
	fi

	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DWITH_FFMPEG=yes
		-DWITH_SYSTEM_FFMPEG=yes
		-DWITH_FULL_RELEASE=yes
		-DWITH_PORTABLE_TOMCRYPT=no
		-DWITH_ALSA=$(usex alsa)
		-DWITH_PULSEAUDIO=$(usex pulseaudio)
		-DWITH_CRASH_HANDLER=$(usex crash-handler)
		-DWITH_GLES2=$(usex gles2)
		-DWITH_GPL_LIBS=$(usex gpl)
		-DWITH_JPEG=$(usex jpeg)
		-DWITH_MP3=$(usex mp3)
		-DWITH_OGG=$(usex ogg)
		-DWITH_WAV=$(usex wav)
		-DWITH_XINERAMA=$(usex xinerama)
		-DWITH_MINIMAID=$(usex minimaid)
		-DWITH_PARALLEL_PORT=$(usex parallel-port)
		-DWITH_PROFILING=$(usex profiling)
		-DWITH_SDL=$(usex sdl)
		-DWITH_SYSTEM_GLEW=yes
		-DWITH_SYSTEM_TOMMATH=yes
		-DWITH_SYSTEM_MAD=yes
		-DWITH_SYSTEM_ZLIB=yes
		-DWITH_SYSTEM_JSONCPP=no # dev-libs/jsoncpp is not a valid version
		-DWITH_SYSTEM_PNG=no  # crashes with 1.6
		-DWITH_SYSTEM_JPEG=yes
		-DWITH_SYSTEM_PCRE=yes
		-DWITH_SYSTEM_OGG=yes
		-DWITH_NETWORKING=$(usex networking)
		-DWITH_LTO=$(usex lto)
		-DWITH_XRANDR=$(usex xrandr)
		-DWITH_JACK=$(usex jack)
		-DWITH_X11=$(usex X)
	)
	cmake_src_configure
}

src_install() {
	cp "${FILESDIR}/${PN}" "${PN}-script"
	sed -i -e "s:@LIBDIR@:$(get_libdir):" "${PN}-script"
	exeinto /usr/bin
	newexe "${PN}-script" "${PN}"
	exeinto /usr/$(get_libdir)/${PN}
	doexe "${PN}" || die "dobin failed"
	doexe GtkModule.so || die "doexe GtkModule.so failed"
	insinto /usr/$(get_libdir)/${PN}
	! [ -d Announcers ] && mkdir Announcers
	doins -r Announcers BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses Data NoteSkins Songs Themes || die "doins failed"
	if ! use bundled-songs; then
		keepdir /usr/$(get_libdir)/${PN}/Songs
	fi
	if ! use bundled-courses; then
		keepdir /usr/$(get_libdir)/${PN}/Courses
	fi
	dodoc -r Docs/* || die "dodoc failed"

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} StepMania
}

# kate: replace-tabs false
