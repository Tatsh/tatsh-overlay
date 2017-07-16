# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils autotools eutils

DESCRIPTION="Advanced rhythm game. Designed for both home and arcade use"
HOMEPAGE="http://www.stepmania.com/"
SRC_URI="https://github.com/stepmania/stepmania/archive/v${PV/_alpha/a}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+crash-handler debug +gles2 +gpl +gtk +jpeg +mp3 +ogg +network +sse2 +wav +xinerama bundled-songs bundled-courses minimaid parallel-port profiling"

# TODO
DEPEND="gtk? ( x11-libs/gtk+:2 )
	media-libs/alsa-lib
	mp3? ( media-libs/libmad )
	ogg? ( media-libs/libvorbis )
	media-libs/libpng
	jpeg? ( virtual/jpeg )
	>=virtual/ffmpeg-9-r1
	media-libs/glew
	x11-libs/libXrandr
	virtual/opengl"

S="${WORKDIR}/${P/_alpha/a}"

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
}

src_configure() {
	mycmakeargs=(
		-DWITH_FFMPEG=OFF
		-DWITH_SYSTEM_FFMPEG=ON
		-DWITH_FULL_RELEASE=ON
		-DWITH_PORTABLE_TOMCRYPT=OFF
		$(cmake-utils_use_with crash-handler CRASH_HANDLER)
		$(cmake-utils_use_with gles2)
		$(cmake-utils_use_with gpl GPL_LIBS)
		$(cmake-utils_use_with gtk GTK2)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with mp3)
		$(cmake-utils_use_with ogg)
		$(cmake-utils_use_with network)
		$(cmake-utils_use_with sse2)
		$(cmake-utils_use_with wav)
		$(cmake-utils_use_with xinerama)
		$(cmake-utils_use_with minimaid)
		$(cmake-utils_use_with parallel-port PARALLEL_PORT)
		$(cmake-utils_use_with profiling)
	)
	cmake-utils_src_configure
}

src_install() {
	dobin src/${PN} || die "dobin $sm-ssc failed"

	insinto "${GAMES_DATADIR}"/${PN}
	if use gtk ; then
		doins src/GtkModule.so || die "doins GtkModule.so failed"
	fi
	[ ! -d Announcers ] && mkdir Announcers
	doins -r Announcers BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses Data NoteSkins Songs Themes || die "doins failed"
	#dodoc -r Docs || die "dodoc failed"

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} Stepmania
}

# kate: replace-tabs false
