# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Video conferencing and web conferencing service client"
HOMEPAGE="http://zoom.us/"
SRC_URI="
	x86? ( https://d11yldzmag5yn.cloudfront.net/prod/1.1.38634.0127/zoom_1.1.38634.0127_i686.tar.xz )
	amd64? ( https://d11yldzmag5yn.cloudfront.net/prod/1.1.38634.0127/zoom_1.1.38634.0127_x86_64.tar.xz )
"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+alsa pulse"
RESTRICT="strip"

DEPEND="
alsa? ( media-libs/alsa-lib )
pulse? ( media-sound/pulseaudio )
dev-libs/atk
dev-libs/glib:2
>=sys-apps/util-linux-2.26.2
>=x11-libs/cairo-1.14.2
>=x11-libs/libX11-1.6.2
>=x11-libs/libXfixes-5.0.1
>=x11-libs/libxcb-1.11.1
virtual/opengl
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /opt/zoom
	doins -r .

	exeinto /opt/bin
	doexe "${FILESDIR}/zoom"
	sofiles=$(< "${FILESDIR}/zoom-1.1.38634.0127-so-files")
	fperms 0755 $sofiles /opt/zoom/{zoom,config-dump}.sh /opt/zoom/zoom /opt/zoom/ZoomLauncher /opt/zoom/QtWebProcess
	dosym /opt/zoom/ZoomLauncher /opt/bin/ZoomLauncher

	make_desktop_entry 'ZoomLauncher %u' ZoomLauncher /opt/zoom/application-x-zoom.png Network 'Path=/opt/zoom\nTerminal=false\nEncoding=UTF-8\nMimeType=x-scheme-handler/zoommtg;\nX-KDE-Protocols=zoommtg'
}
