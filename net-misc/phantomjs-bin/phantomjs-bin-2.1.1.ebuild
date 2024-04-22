# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="Headless browser (fork) intended for use with yt-dlp."
HOMEPAGE="https://github.com/coyove/phantomjs"
QTWEBKIT_SHA="2d2b3794dd79e0379f9dba7b653b80e4f8cbde04"
MY_PN="${PN/-bin}"
SRC_URI="https://github.com/coyove/${MY_PN}/releases/download/v${PV}/${MY_PN} -> ${MY_PN}.appimage"
RESTRICT="strip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore:5
	dev-libs/hyphen
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/libtasn1
	dev-libs/libxml2
	dev-libs/libxslt
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtpositioning:5
	dev-qt/qtwidgets:5
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libpng
	media-libs/libwebp
	sys-libs/zlib"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${MY_PN}.appimage" . || die
	chmod +x "${MY_PN}.appimage" || die
	"./${MY_PN}.appimage" --appimage-extract
}

src_install() {
	local -r libdir="/usr/$(get_libdir)/${MY_PN}"
	exeinto "${libdir}"
	doexe "squashfs-root/usr/bin/${MY_PN}"
	cp squashfs-root/lib/{libQt5WebKit.so.5,libQt5WebKitWidgets.so.5,libicudata.so.66,libicui18n.so.66,libicuuc.so.66,libjpeg.so.8,libwoff2dec.so.1.0.2,libwoff2common.so.1.0.2} "${D}${libdir}" || die
	make_wrapper "${MY_PN}" "${libdir}/${MY_PN}" "${libdir}" "${libdir}"
}
