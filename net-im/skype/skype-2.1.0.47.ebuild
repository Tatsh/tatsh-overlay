# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/skype/skype-2.0.0.72.ebuild,v 1.3 2009/04/14 09:38:40 armin76 Exp $

EAPI=2

inherit eutils qt4 pax-utils

DESCRIPTION="A P2P-VoiceIP client."
HOMEPAGE="http://www.skype.com/"

S_P="${PN}_static-${PV}"
SRC_URI="
	!qt-static? ( http://download.${PN}.com/linux/${P}.tar.bz2 )
	qt-static? ( http://download.${PN}.com/linux/${S_P}.tar.bz2 )
"

LICENSE="skype-eula"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt-static"
RESTRICT="mirror strip"

DEPEND="amd64? (
		>=app-emulation/emul-linux-x86-baselibs-2.1.1
		app-emulation/emul-linux-x86-compat
		>=app-emulation/emul-linux-x86-soundlibs-2.4
		>=app-emulation/emul-linux-x86-xlibs-1.2
	)
	x86? (
		>=media-libs/alsa-lib-1.0.11
		>=sys-libs/glibc-2.4
		x11-libs/libXScrnSaver
		x11-libs/libXv
		qt-static? (
			media-libs/fontconfig
			media-libs/freetype
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libXcursor
			x11-libs/libXext
			x11-libs/libXfixes
			x11-libs/libXi
			x11-libs/libXinerama
			x11-libs/libXrandr
			x11-libs/libXrender
			x11-libs/libX11
		)
		!qt-static? (
			x11-libs/qt-gui:4[accessibility,dbus]
			x11-libs/qt-dbus:4
			x11-libs/libX11
			x11-libs/libXau
			x11-libs/libXdmcp
		)
	)
"
RDEPEND="${DEPEND}"

QA_EXECSTACK="opt/${PN}/${PN}"

use qt-static && S="${WORKDIR}/${S_P}"

src_install() {
	exeinto /opt/${PN}
	doexe ${PN} || die
	fowners root:audio /opt/${PN}/${PN}
	make_wrapper ${PN} /opt/${PN}/${PN} /opt/${PN} /opt/${PN} /usr/bin

	insinto /opt/${PN}/sounds
	doins sounds/*.wav || die

	if ! use qt-static ; then
		insinto /etc/dbus-1/system.d
		doins ${PN}.conf || die
	fi

	insinto /opt/${PN}/lang
	#
	#There have been some issues were lang is not updated from the .ts files
	#but if we have qt we can rebuild it
	#
	if ! use qt-static ; then
		lrelease lang/*.ts
	fi

	doins lang/*.qm || die

	insinto /opt/${PN}/avatars
	doins avatars/*.png || die

	insinto /opt/${PN}
	for X in 16 32 48
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}"/icons/SkypeBlue_${X}x${X}.png ${PN}.png || die
	done

	dodoc README || die

	# insinto /usr/share/applications/
	# doins skype.desktop
	make_desktop_entry ${PN} "Skype VoIP" ${PN} "Network;InstantMessaging;Telephony"

	#Fix for no sound notifications
	dosym /opt/${PN} /usr/share/${PN}

	# TODO: Optional configuration of callto:// in KDE, Mozilla and friends
	# doexe skype-callto-handler
}
