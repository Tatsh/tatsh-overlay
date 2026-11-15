# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..15} )
MPV_REQ_USE="lua"
USE_MPV="rdepend"
inherit mpv-plugin python-any-r1

DESCRIPTION="mpv plugin for automatic reloading of slow/stuck video streams"
HOMEPAGE="https://github.com/4e6/mpv-reload"
SHA="fb7a26e21e581fcac4eeee9291de0ff788dc1a47"
SRC_URI="https://github.com/4e6/mpv-reload/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-${PN}-${SHA}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"
IUSE="test"
RESTRICT="!test? ( test )"

# The tests drive a real, headless mpv and make their media with ffmpeg.
BDEPEND="
	test? (
		${PYTHON_DEPS}
		media-video/ffmpeg
		media-video/mpv[lua]
	)
"

MPV_PLUGIN_FILES=( main.lua )

# The test server answers HTTP/1.0 without "Connection: close"; FFmpeg 8 then
# reuses the closed socket when the Matroska demuxer seeks back from the cues.
PATCHES=( "${FILESDIR}/${PN}-test-server-connection-close.patch" )

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_test() {
	"${EPYTHON}" tests/run.py || die "Tests failed with ${EPYTHON}"
}
