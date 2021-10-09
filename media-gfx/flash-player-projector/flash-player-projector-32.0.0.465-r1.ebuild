# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop xdg

DESCRIPTION="Stand-alone viewer of SWF files."
HOMEPAGE="https://www.adobe.com/support/flashplayer/debug_downloads.html"
SRC_URI="https://fpdownload.macromedia.com/pub/flashplayer/updaters/32/flash_player_sa_linux.x86_64.tar.gz -> ${P}.tar.gz
	https://fpdownload.adobe.com/pub/flashplayer/pdc/${PV}/flash_player_npapi_linux.x86_64.tar.gz -> ${PN}-${PV}-assets.tar.gz"

LICENSE="AdobeFlash-11.x"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	virtual/opengl
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrender
	x11-libs/pango"
DEPEND="${RDEPEND}"

S="${WORKDIR}"
QA_PREBUILT="/usr/bin/flashplayer"

src_install() {
	local s
	dobin flashplayer
	for s in 48 32 24 16; do
		newicon -s "$s" "usr/share/icons/hicolor/${s}x${s}/apps/flash-player-properties.png" "${PN}.png"
	done
	make_desktop_entry \
		'flashplayer %F' \
		'Flash Player Projector' \
		"$PN" \
		AudioVideo \
		"GenericName=Video player\nMimeType=application/x-shockwave-flash;x-scheme-handler/http;x-scheme-handler/https;"
	einstalldocs
}
