# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit desktop xdg-utils xdg

DESCRIPTION="Yet another video conference client."
HOMEPAGE="https://zoom.us"
SRC_URI="
	amd64? ( https://zoom.us/client/latest/${PN}_x86_64.tar.xz -> ${P}.tar.xz )
	x86? ( https://zoom.us/client/latest/${PN}_i686.tar.xz -> ${P}.tar.xz )"
RESTRICT="mirror strip"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT="opt/.*"
QA_EXECSTACK="opt/zoom/zoom"

RDEPEND=""
DEPEND="${RDEPEND} dev-qt/qtpositioning:5
	dev-qt/qtwebengine:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtwebchannel:5[qml]
	dev-qt/qtgui:5[egl,eglfs,evdev,tuio,xcb]
	dev-qt/qtscript:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5[xcb]
	dev-qt/qtprintsupport:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qtmultimedia:5
	>=x11-libs/libxcb-1.12
	>=x11-libs/xcb-util-keysyms-0.4.0
	>=x11-libs/xcb-util-xrm-1.2
	>=x11-libs/xcb-util-image-0.4.0
	dev-libs/glib:2
"

DOCS=( version.txt )

S="${WORKDIR}/zoom"

src_install() {
	insinto /usr/share/applications
	doins "${FILESDIR}/Zoom"*.desktop

	insinto /opt/zoom
	doins -r timezones translations
	doins *.pem *.cer *.pcm
	exeinto /opt/zoom
	doexe ZoomLauncher zoom zopen zoomlinux *.sh
	doicon -s 96 Zoom.png
	dosym ../zoom/zoom /opt/bin/zoom
}
