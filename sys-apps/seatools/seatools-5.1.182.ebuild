# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Quick diagnostic tool that checks the health of your drive."
HOMEPAGE="https://www.seagate.com/support/downloads/seatools/"
SRC_URI="https://www.seagate.com/content/dam/seagate/migrated-assets/www-content/support-content/downloads/${PN}/_shared/downloads/SeaToolsLinuxX64Installer.zip -> ${P}.zip
	https://www.seagate.com/content/dam/seagate/migrated-assets/www-content/support-content/_shared/images/${PN}-icon.png"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip splitdebug"

RDEPEND="dev-libs/glib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXext
	x11-libs/libxkbcommon
	x11-libs/libXrender"
BDEPEND="app-arch/bitrock-unpacker"

S="${WORKDIR}/${P}/default/programfileslinux"

HTML_DOCS=( help/SeaTools.README-US.html )

src_unpack() {
	default
	bitrock-unpacker SeaToolsLinuxX64Installer.run "${P}" || die
}

src_prepare() {
	rm ./*.sh ./*.ico "exec-${PN}-in-dir" || die
	chmod +x SeaTools plugins/*/*.so || die
	default
}

src_install() {
	einstalldocs
	rm -fR help || die
	mkdir -p "${D}/opt/seatools" || die
	cp -Rv ./* "${D}/opt/seatools" || die
	make_wrapper "${PN}" "/opt/${PN}/SeaTools" "/opt/${PN}"
	newicon "${DISTDIR}/${PN}-icon.png" "${PN}.png"
	make_desktop_entry "${PN}" SeaTools "${PN}" System 'X-KDE-SubstituteUID=true\nX-KDE-Username='
}
