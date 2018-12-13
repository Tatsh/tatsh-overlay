# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils autotools eutils

DESCRIPTION="Advanced rhythm game. Designed for both home and arcade use"
HOMEPAGE="http://www.stepmania.com/"
SRC_URI="https://github.com/stepmania/stepmania/archive/v${PV/_beta/-b}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+crash-handler debug +gles2 +gpl +gtk +jpeg +mp3 +ogg +sse2 +wav +xinerama bundled-songs bundled-courses minimaid parallel-port profiling"

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

S="${WORKDIR}/${P/_beta/-b}"

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

	default
}

src_configure() {
	mycmakeargs=(
		-DWITH_FFMPEG=OFF
		-DWITH_SYSTEM_FFMPEG=ON
		-DWITH_FULL_RELEASE=ON
		-DWITH_PORTABLE_TOMCRYPT=OFF
		-DWITH_CRASH_HANDLER=$(usex crash-handler)
		-DWITH_GLES2=$(usex gles2)
		-DWITH_GPL_LIBS=$(usex gpl)
		-DWITH_GTK2=$(usex gtk)
		-DWITH_JPEG=$(usex jpeg)
		-DWITH_MP3=$(usex mp3)
		-DWITH_OGG=$(usex ogg)
		-DWITH_SSE2=$(usex sse2)
		-DWITH_WAV=$(usex wav)
		-DWITH_XINERAMA=$(usex xinerama)
		-DWITH_MINIMAID=$(usex minimaid)
		-DWITH_PARALLEL_PORT=$(usex parallel-port)
		-DWITH_PROFILING=$(usex profiling)
	)
	cmake-utils_src_configure
}

src_install() {
	into /usr
	dobin "${FILESDIR}/${PN}"
	exeinto /usr/share/${PN}
	doexe "${PN}" || die "dobin failed"
	if use gtk; then
		doexe GtkModule.so || die "doexe GtkModule.so failed"
	fi
	insinto /usr/share/${PN}
	! [ -d Announcers ] && mkdir Announcers
	doins -r Announcers BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses Data NoteSkins Songs Themes || die "doins failed"
	dodoc -r Docs/* || die "dodoc failed"

	newicon "Themes/default/Graphics/Common window icon.png" ${PN}.png
	make_desktop_entry ${PN} Stepmania
}

# kate: replace-tabs false
