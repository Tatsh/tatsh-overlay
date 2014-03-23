# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit games

DESCRIPTION="Rhythm-based action platforming"
HOMEPAGE="http://www.bittripgame.com/"
SRC_URI="
	x86? ( bit.trip.runner-linux-1.0-4_i386-1348702546.tar.gz )
	amd64? ( bit.trip.runner_1.0-4_amd64-1348702546.tar.gz )
"
RESTRICT="fetch mirror strip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=media-libs/libsdl-1.2
	media-libs/libogg
	media-libs/libvorbis
	sys-libs/zlib
	virtual/opengl"

S="${WORKDIR}/bit.trip.runner-1.0"

src_install() {
	dodoc README ThirdPartyLicenses.txt install
	dohtml README.html

	insinto "${GAMES_PREFIX_OPT}"
	doins -r bit.trip.runner
	exeinto ${GAMES_PREFIX_OPT}/bit.trip.runner
	doexe bit.trip.runner/bit.trip.runner

	exeinto "${GAMES_PREFIX_OPT}/bin"
	doexe "${FILESDIR}/${PN}"

	newicon -s 48 bit.trip.runner/RUNNER.png "${PN}.png"
	make_desktop_entry "${PN}" 'BIT.TRIP RUNNER'
}

pkg_postinst() {
	einfo
	einfo "To disable full screen, create a file:"
	einfo
	einfo "    ~/.gaijin_games/bit.trip.runner/game.cfg"
	einfo
	einfo "with contents: "
	einfo
	cat <<EOF
Fullscreen = no
WindowSize = 1280x720
SoundDevice = ALSA Default
Resolution = 1920x1080x32
VSync = yes
EnableVibration = yes
EOF
	einfo
}
