# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

MY_PN="LocalSend"
MY_PN_LC="localsend"

DESCRIPTION="Share files to nearby devices over the local network."
HOMEPAGE="https://localsend.org https://github.com/localsend/localsend"
SRC_URI="https://github.com/${MY_PN_LC}/${MY_PN_LC}/releases/download/v${PV}/${MY_PN}-${PV}-linux-x86-64.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}"

# The bundle ships the Flutter engine and Dart runtime alongside the app.
LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip test"

# libtray_manager_plugin.so links all four ayatana/dbusmenu sonames directly.
RDEPEND="
	dev-libs/ayatana-ido
	dev-libs/glib:2
	dev-libs/libayatana-appindicator
	dev-libs/libayatana-indicator
	dev-libs/libdbusmenu
	x11-libs/gtk+:3
"

QA_PREBUILT="opt/${MY_PN_LC}/*"

src_install() {
	insinto "/opt/${MY_PN_LC}"
	doins -r data lib
	exeinto "/opt/${MY_PN_LC}"
	doexe "${MY_PN_LC}_app"
	# The plugins are dlopened from lib/ next to the executable.
	exeinto "/opt/${MY_PN_LC}/lib"
	doexe lib/*.so

	dosym "../../opt/${MY_PN_LC}/${MY_PN_LC}_app" "/usr/bin/${MY_PN_LC}"

	newicon -s 512 "data/flutter_assets/assets/img/logo-512.png" "${MY_PN_LC}.png"
	make_desktop_entry "${MY_PN_LC}" "${MY_PN}" "${MY_PN_LC}" "Network;FileTransfer"
}
