# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit games autotools eutils mercurial

DESCRIPTION="Stepmania 5 sm-ssc branch"
HOMEPAGE="http://sm-ssc.googlecode.com"
SRC_URI=""

EHG_REPO_URI="https://sm-ssc.googlecode.com/hg/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug X gtk +jpeg +mad +vorbis +network +ffmpeg bundled-libs beat kb7 ppp piu bundled-songs bundled-courses extra-noteskins"

DEPEND="gtk? ( x11-libs/gtk+:2 )
	media-libs/alsa-lib
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )
	media-libs/libpng
	jpeg? ( virtual/jpeg )
	ffmpeg? ( >=virtual/ffmpeg-0.5 )
	media-libs/glew
	x11-libs/libXrandr
	virtual/opengl
	!bundled-libs? ( dev-libs/libpcre )"

S="${WORKDIR}/hg"

remove_bundled_lib() {
	local blib_prefix
	blib_prefix="${S}/src"
	einfo "Removing bundled library $1 ..."
	rm -rf "${blib_prefix}/$1" || die "Failed removing bundled library $1"
}

remove_dev_theme() {
	local theme_dir
	theme_dir="${S}/Themes"
	einfo "Removing dev theme $1 ..."
	rm -rf "${theme_dir}/$1" || die "Failed removing dev theme $1"
}

remove_noteskin_for_game() {
	local noteskin_dir
	noteskin_dir="${S}/NoteSkins"
	einfo "Removing note skins for game $2 ..."
	rm -rf "${noteskin_dir}/$1" || die "Failed removing noteskin directory $1"
}

remove_dance_noteskin() {
	local noteskin_dir
	noteskin_dir="${S}/NoteSkins/dance"
	einfo "Removing dance note skin $1 ..."
	rm -rf "${noteskin_dir}/$1" || die "Failed removing noteskin directory ${noteskin_dir}/$1"
}

src_prepare() {
	# Remove bundled libs, to know if they become forked as lua already is.
	if ! use bundled-libs; then
		remove_bundled_lib "ffmpeg"
		remove_bundled_lib "libjpeg"
		remove_bundled_lib "libpng"
		#remove_bundled_lib "libtomcrypt"
		#remove_bundled_lib "libtommath"
		remove_bundled_lib "mad-0.15.1b"
		remove_bundled_lib "pcre"
		remove_bundled_lib "vorbis"
		remove_bundled_lib "zlib"
	fi

	# Remove dev themes
	remove_dev_theme "default-dev-midi"
	remove_dev_theme "HelloWorld"
	remove_dev_theme "MouseTest"
	remove_dev_theme "rsr"
	remove_dev_theme "home"
	remove_dev_theme "_Installer"
	remove_dev_theme "new"
	remove_dev_theme "_portKit-sm4"
	remove_dev_theme "test"
	remove_dev_theme "themekit"
	remove_dev_theme "_themekit-piu"

	einfo 'Removing useless instructions.txt files ...'
	find . -type f -iname 'instructions.txt' -exec rm -f {} \;

	einfo 'Removing useless _assets directory ...'
	rm -fR _assets

	# Noteskins
	if ! use beat; then
		remove_noteskin_for_game "beat" "beatmania/beatmaniaIIDX/beatmaniaIII"
	fi
	if ! use kb7; then
		remove_noteskin_for_game "kb7" "Keyboardmania"
	fi
	if ! use ppp; then
		remove_noteskin_for_game "Para" "ParaParaParadise"
	fi
	if ! use piu; then
		remove_noteskin_for_game "pump" "Pump It Up"
	fi
	remove_noteskin_for_game "lights" "(n/a)"
	remove_noteskin_for_game "techno" "(Unknown)"
	# Dance noteskins, keep everything except default
	if ! use extra-noteskins; then
		for dir in "${S}/NoteSkins/dance"/*; do
			if [[ "$dir" = *default ]]; then
				continue
			fi
			remove_dance_noteskin "$(basename "$dir")"
		done
	fi

	# Built-in songs and courses
	if ! use bundled-courses; then
		einfo 'Removing bundled courses'
		rm -rf "${S}/Courses/Default"
	fi
	if ! use bundled-songs; then
		einfo 'Removing bundled songs'
		rm -rf "${S}/Songs/StepMania 5"
	fi

	# Apply various patches
	#	00 - 09: Filepath changes
	#	10 - 19: De-bundle patches
	#	20 - 29: Other fixes
	#	30 - 39; Non-important gameplay patches
	EPATCH_SOURCE="${FILESDIR}" EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="no" epatch || die "Patching failed!"

	# This is used instead of running StepMania's autogen.sh
	eautoreconf
}

src_configure() {
	myconf=""
	if ! use bundled-libs; then
		einfo "Disabling bundled libraries.."
		myconf="${myconf} --with-system-pcre"
	fi
	egamesconf \
	--disable-dependency-tracking \
	--enable-lua-binaries \
	--with-extdatadir \
	$(use_enable gtk gtk2) \
	$(use_with debug) \
	$(use_with X x) \
	$(use_with jpeg) \
	$(use_with mad mp3) \
	$(use_with vorbis) \
	$(use_with network) \
	$(use_with ffmpeg) \
	${myconf}
}

src_install() {
	dogamesbin src/${PN} || die "dogamesbin $sm-ssc failed"

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

	prepgamesdirs

	# Ensure that game can write to Data folder
	fperms -R 775 "${GAMES_DATADIR}"/${PN}/Data
}
