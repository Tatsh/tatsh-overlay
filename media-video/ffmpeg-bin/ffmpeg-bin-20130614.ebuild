# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Complete solution to record, convert and stream audio and video (static build)."
HOMEPAGE="http://ffmpeg.gusari.org/static/"
SRC_URI="http://ffmpeg.gusari.org/static/64bit/ffmpeg.static.64bit.2013-06-14.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ffprobe"

DEPEND=""
RDEPEND="${DEPEND}"

RESTRICT="strip"
QA_PREBUILT="ffmpeg-9999
ffprobe-9999"

S="${WORKDIR}"

src_install() {
	mv ffmpeg ffmpeg-9999
	mv ffprobe ffprobe-9999

	exeinto /usr/bin
	doexe ffmpeg-9999
	if use ffprobe; then
		doexe ffprobe-9999
	fi
}

pkg_postinst() {
	einfo
	einfo "To use this version, use ffmpeg-9999 and ffprobe-9999"
	einfo
}
