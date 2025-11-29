# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Free version of the code analyzer."
HOMEPAGE="https://hex-rays.com/ida-free"
SRC_URI="${P}.run"
S="${WORKDIR}/ida/programfiles"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"
RESTRICT="fetch strip splitdebug"

RDEPEND="app-crypt/mit-krb5
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	virtual/zlib
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-renderutil
	x11-libs/xcb-util-wm
	wayland? ( dev-libs/wayland dev-qt/qtwayland )"
BDEPEND="app-arch/bitrock-unpacker"

src_unpack() {
	cp "${DISTDIR}/${A}" . || die
	bitrock-unpacker "${A}" "${WORKDIR}" || die
	rm "${A}" || die
}

src_install() {
	einstalldocs
	mkdir -p "${D}/opt/ida" || die
	cp -Rv ./* "${D}/opt/ida" || die
	newicon appico.png "${PN}.png"
	make_wrapper ida "${EPREFIX}/opt/ida/ida" "${EPREFIX}/opt/ida"
	make_desktop_entry ida IDA "${PN}"
}
