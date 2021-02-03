# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop wrapper

DESCRIPTION="Advanced rhythm game. Designed for both home and arcade use"
HOMEPAGE="http://www.stepmania.com/"

UPPER_PN="${PN^^}"
MY_PN="${UPPER_PN:0:1}${PN:1:9}${UPPER_PN:10:1}${PN:11}"
MY_PV="${PV/5.3.}"
MY_PV="${MY_PV/_alpha}"
SRC_URI="amd64? ( https://github.com/TeamRizu/OutFox/releases/download/OF${MY_PV}/${MY_PN}-Alpha-${MY_PV}-amd64-date-20201216.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/TeamRizu/OutFox/releases/download/OF${MY_PV}/${MY_PN}-Alpha-${MY_PV}-arm64v8-date-20201217.tar.gz -> ${P}-arm64.tar.gz )
	arm? ( https://github.com/TeamRizu/OutFox/releases/download/OF${MY_PV}/${MY_PN}-Alpha-${MY_PV}-arm32v7-date-20201216.tar.gz -> ${P}-arm.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE="bundled-songs bundled-courses doc"
BDEPEND="dev-util/patchelf"
RDEPEND="app-arch/bzip2
	app-arch/lz4
	media-libs/alsa-lib
	media-libs/flac
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/vulkan-loader
	media-sound/pulseaudio
	virtual/glu
	virtual/jack
	virtual/opengl
	virtual/udev"
RESTRICT="splitdebug"

pkg_setup() {
	if use amd64; then
		S="${WORKDIR}/${MY_PN}-Alpha-${MY_PV}-amd64-date-20201216"
	elif use arm64; then
		S="${WORKDIR}/${MY_PN}-Alpha-${MY_PV}-arm64v8-date-20201217"
	elif use arm; then
		S="${WORKDIR}/${MY_PN}-Alpha-${MY_PV}-arm32v7-date-20201216 )"
	else
		eerror 'Unsupported architecture'
		die
	fi
	export S
}

src_prepare() {
	einfo 'Removing useless instructions.txt files ...'
	find . -type f -iname 'instructions.txt' -exec rm -f {} \;
	# Built-in songs and courses
	if ! use bundled-courses; then
		einfo 'Removing bundled courses'
		rm -rf "Courses/Default"
	fi
	if ! use bundled-songs; then
		einfo 'Removing bundled songs'
		rm -rf 'Songs/StepMania 5' Songs/Outfox
	fi
	default
}

src_install() {
	local inst="${EPREFIX}/opt/${PN}"
	patchelf --set-rpath "\$ORIGIN:${EPREFIX}/lib64:${EPREIFX}/usr/lib64" \
		stepmania || die 'Failed to patch ELFs'
	patchelf --replace-needed libbz2.so.1.0 libbz2.so.1 \
		libav{codec,format}.so.* || die "Failed to patch ELFs"
	make_wrapper "$PN" "${inst}/stepmania" "${inst}" "${inst}" /usr/bin
	insinto "$inst"
	doins -r Announcers Appearance BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses Data Scripts Songs
	! use bundled-songs && keepdir "${inst}/Songs"
	! use bundled-courses && keepdir "${inst}/Courses"
	exeinto "${inst}"
	doexe stepmania *.so*
	use doc && dodoc -r Docs/*
	newicon "Appearance/Themes/default/Graphics/Common window icon.png" \
		${PN}.png
	make_desktop_entry "${PN}" "StepMania OutFox"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
