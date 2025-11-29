# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Frontend for emulators, game engines and media players"
HOMEPAGE="https://www.retroarch.com/"
SRC_URI="https://github.com/libretro/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="alsa cg cpu_flags_x86_sse dbus egl ffmpeg flac freetype gamemode gles gles3 kms
	libcaca libusb materialui openal +opengl opengl_core +ozone
	parport plain_drm pulseaudio qt5 rgui sdl +sdl2 sixel subtitles ssl stripes
	systemd tinyalsa udev vulkan X xrandr xmb xv wayland +zlib"

MY_PN=RetroArch
MY_P=${MY_PN}-${PV}

MENU_REQUIRED_USE="|| ( gles opengl vulkan )"
REQUIRED_USE="
	cg? ( opengl )
	gles? ( egl )
	gles3? ( gles )
	kms? ( egl )
	materialui? (
		${MENU_REQUIRED_USE}
	)
	opengl? ( !gles )
	ozone? ( ${MENU_REQUIRED_USE} )
	rgui? (
		|| ( ${MENU_REQUIRED_USE} libcaca sdl sdl2 sixel )
	)
	stripes? ( ${MENU_REQUIRED_USE} )
	xmb? ( ${MENU_REQUIRED_USE} )
	sdl? ( !sdl2 )
	xv? ( X )
"

RDEPEND="
	games-emulation/libretro-common-overlays
	games-emulation/libretro-database
	games-emulation/libretro-info
	games-emulation/retroarch-assets
	media-libs/mesa[opengl]
	alsa? ( media-libs/alsa-lib )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac )
	freetype? ( media-libs/freetype )
	gamemode? ( games-util/gamemode )
	kms? (
		x11-libs/libdrm
	)
	libcaca? ( media-libs/libcaca )
	libusb? ( virtual/libusb:= )
	materialui? ( games-emulation/retroarch-assets[materialui] )
	openal? ( media-libs/openal )
	opengl? ( virtual/opengl )
	ozone? ( games-emulation/retroarch-assets[ozone] )
	pulseaudio? ( media-libs/libpulse )
	qt5? (
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtnetwork:5
		dev-qt/qtwidgets:5
	)
	rgui? ( games-emulation/retroarch-assets[rgui] )
	sdl? ( media-libs/libsdl )
	sdl2? ( media-libs/libsdl2 )
	sixel? ( media-libs/libsixel )
	ssl? ( net-libs/mbedtls )
	subtitles? ( media-libs/libass )
	systemd? ( sys-apps/systemd )
	udev? ( virtual/udev )
	vulkan? ( media-libs/vulkan-loader[X?,wayland?] )
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/libxcb
	)
	xmb? ( games-emulation/retroarch-assets[xmb] )
	xrandr? ( x11-libs/libXrandr )
	xv? ( x11-libs/libXv )
	wayland? (
		dev-libs/wayland
		dev-libs/wayland-protocols
	)
	zlib? ( virtual/zlib )
"
DEPEND="${RDEPEND}
	vulkan? ( dev-util/vulkan-headers )
	virtual/pkgconfig"

src_prepare() {
	default

	# RetroArch's configure is shell script, not autoconf one
	# However it tries to mimic autoconf configure options
	sed -i -e \
		's#\(''\))\( : ;;\)#\1|--infodir=*|--datadir=*|--localstatedir=*|--libdir=*)\2#g' \
		qb/qb.params.sh || die

	local -r LIBRETRO_LIB_DIR="${EPREFIX}/usr/$(get_libdir)/libretro"
	local LIBRETRO_DATA_DIR="${EPREFIX}/usr/share/libretro"
	local RETROARCH_DATA_DIR="${EPREFIX}/usr/share/${PN}"
	sed -i \
		-e "s:# \(assets_directory =\):\1 \"${RETROARCH_DATA_DIR}/assets\":g" \
		-e "s:# \(joypad_autoconfig_dir =\):\1 \"${RETROARCH_DATA_DIR}/autoconfig\":g" \
		-e "s:# \(cheat_database_path =\):\1 \"${LIBRETRO_DATA_DIR}/database/cht\":g" \
		-e "s:# \(content_database_path =\):\1 \"${LIBRETRO_DATA_DIR}/database/rdb\":g" \
		-e "s:# \(cursor_directory =\):\1 \"${LIBRETRO_DATA_DIR}/database/cursors\":g" \
		-e "s:# \(libretro_directory =\):\1 \"${LIBRETRO_LIB_DIR}\":g" \
		-e "s:# \(libretro_info_path =\):\1 \"${LIBRETRO_DATA_DIR}/info\":g" \
		-e "s:# \(overlay_directory =\):\1 \"${RETROARCH_DATA_DIR}/overlay\":g" \
		-e "s:# \(video_shader_dir =\):\1 \"${LIBRETRO_DATA_DIR}/shaders\":g" \
		retroarch.cfg || die
}

src_configure() {
	if use cg; then
		append-ldflags "-L/opt/nvidia-cg-toolkit/$(get_libdir)"
		append-cppflags -I/opt/nvidia-cg-toolkit/include
	fi

	econf \
		--enable-mmap \
		--enable-networking \
		--enable-threads \
		--disable-audioio \
		--disable-builtinflac \
		--disable-builtinmbedtls \
		--disable-builtinzlib \
		--disable-coreaudio \
		--disable-jack \
		--disable-mpv \
		--disable-oss \
		--disable-roar \
		--disable-rsound \
		--disable-videocore \
		"$(use_enable alsa)" \
		"$(use_enable cg)" \
		"$(use_enable cpu_flags_x86_sse sse)" \
		"$(use_enable dbus)" \
		"$(use_enable egl)" \
		"$(use_enable freetype)" \
		"$(use_enable flac)" \
		"$(use_enable ffmpeg)" \
		"$(use_enable gles opengles)" \
		"$(use_enable gles3 opengles3)" \
		"$(use_enable kms)" \
		"$(use_enable libcaca caca)" \
		"$(use_enable libusb)" \
		"$(use_enable libusb hid)" \
		"$(use_enable materialui)" \
		"$(use_enable openal al)" \
		"$(use_enable opengl)" \
		"$(use_enable opengl_core)" \
		"$(use_enable ozone)" \
		"$(use_enable parport)" \
		"$(use_enable plain_drm)" \
		"$(use_enable pulseaudio pulse)" \
		"$(use_enable qt5 qt)" \
		"$(use_enable sdl)" \
		"$(use_enable sdl2)" \
		"$(use_enable sixel)" \
		"$(use_enable subtitles ssa)" \
		"$(use_enable ssl)" \
		"$(use_enable systemd)" \
		"$(use_enable tinyalsa)" \
		"$(use_enable udev)" \
		"$(use_enable vulkan)" \
		"$(use_enable wayland)" \
		"$(use_enable X x11)" \
		"$(use_enable xrandr)" \
		"$(use_enable xv xvideo)" \
		"$(use_enable zlib)"
}
