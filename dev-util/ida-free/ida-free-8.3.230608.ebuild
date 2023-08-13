# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Free version of the code analyzer."
HOMEPAGE="https://hex-rays.com/ida-free/"
SRC_URI="https://out7.hex-rays.com/files/idafree83_linux.run -> ${P}.run"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip splitdebug"

RDEPEND="${DEPEND}
	app-crypt/mit-krb5
	dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon"
BDEPEND="app-arch/bitrock-unpacker"

S="${WORKDIR}/ida/programfiles_custom"

src_unpack() {
	cp "${DISTDIR}/${A}" . || die
	bitrock-unpacker "${A}" "${WORKDIR}" || die
	rm "${A}" || die
}

src_install() {
	einstalldocs
	mkdir -p "${D}/opt/ida" || die
	cp -Rv ./* "${D}/opt/ida" || die
	newicon appico64.png "${PN}.png"
	make_wrapper ida64 "${EPREFIX}/opt/ida/ida64" "${EPREFIX}/opt/ida"
	make_desktop_entry ida64 IDA "${PN}"
}
