# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper xdg

DESCRIPTION="Advanced rhythm game. Designed for both home and arcade use"
HOMEPAGE="https://projectoutfox.com/"

UPPER_PN="${PN^^}"
MY_PN="${UPPER_PN:0:1}${PN:1:1}${PN:2:1}${UPPER_PN:3:1}${PN:4}"
DATE="20250804"
MAJOR="${PV:0:5}"
PRE="${PV:7}"
SRC_URI="${MY_PN}-alpha-${MAJOR}-pre0${PRE}-a40-24.04-amd64-current-date-${DATE}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bundled-songs +bundled-courses doc"
BDEPEND="dev-util/patchelf"
RDEPEND="app-arch/bzip2
	app-arch/lz4
	media-libs/alsa-lib
	media-libs/flac
	media-libs/libglvnd[X]
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/vulkan-loader
	media-libs/libpulse
	net-nds/openldap
	virtual/glu
	virtual/jack
	virtual/udev
	media-video/ffmpeg
	virtual/libusb"
RESTRICT="fetch splitdebug strip"

S="${WORKDIR}"

src_prepare() {
	if use amd64; then
		cd "${MY_PN}-alpha-${MAJOR}-pre0${PRE}-a40-24.04-amd64-current-date-${DATE}" || die
	else
		die 'Unsupported architecture'
	fi
	einfo 'Removing useless instructions.txt files ...'
	find . -type f -iname 'instructions.txt' -exec rm -f {} \;
	# Built-in songs and courses
	if ! use bundled-courses; then
		einfo 'Removing bundled courses'
		rm -rf "Courses/Default"
	fi
	if ! use bundled-songs; then
		einfo 'Removing bundled songs'
		rm -rf Songs/Outfox
	fi
	default
}

src_install() {
	cd "${MY_PN}-alpha-${MAJOR}-pre0${PRE}-a40-24.04-amd64-current-date-${DATE}" || die
	local inst="${EPREFIX}/opt/${PN}"
	patchelf --set-rpath "\$ORIGIN:${EPREFIX}/lib64:${EPREIFX}/usr/lib64" \
		OutFox || die 'Failed to patch ELFs'
	patchelf --replace-needed libbz2.so.1.0 libbz2.so.1 \
		libav{codec,format}.so.* || die "Failed to patch ELFs"
	make_wrapper "$PN" "${inst}/OutFox" "${inst}" "${inst}" /usr/bin
	insinto "$inst"
	doins -r Announcers Appearance BackgroundEffects BackgroundTransitions \
		BGAnimations Characters Courses DanceStages Data Modules Scripts Songs
	! use bundled-songs && keepdir "${inst}/Songs"
	! use bundled-courses && keepdir "${inst}/Courses"
	exeinto "${inst}"
	doexe OutFox ./*.so*
	use doc && dodoc -r Docs/*
	newicon "Appearance/Themes/default/Graphics/Common window icon.png" \
		"${PN}.png"
	make_desktop_entry "${PN}" "OutFox"
}
