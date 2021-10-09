# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm systemd xdg

DESCRIPTION="Free VPN-only version of FortiClient."
HOMEPAGE="https://www.fortinet.com/support/product-downloads#vpn"
SRC_URI="https://filestore.fortinet.com/${PN}/downloads/${PN}_vpn_${PV}_x86_64.rpm"
RESTRICT="mirror strip"

LICENSE="Fortinet GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-accessibility/at-spi2-atk
	app-crypt/libsecret[crypt]
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/libpng:0/16
	net-dialup/ppp
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-auth/polkit
	virtual/libudev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libnotify
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/pango"

S="${WORKDIR}"

QA_PREBUILT="opt/forticlient/fctsched
	opt/forticlient/fortivpn
	opt/forticlient/gui/FortiClient-linux-x64/libEGL.so
	opt/forticlient/gui/FortiClient-linux-x64/libffmpeg.so
	opt/forticlient/gui/FortiClient-linux-x64/FortiClient
	opt/forticlient/gui/FortiClient-linux-x64/libGLESv2.so
	opt/forticlient/fortitray
	opt/forticlient/vpn
	opt/forticlient/update_tls
	opt/forticlient/fortitraylauncher
	opt/forticlient/confighandler
	opt/forticlient/update"

src_install() {
	echo "CONFIG_PROTECT_MASK=\"/etc/${PN}/config.db\"" > "99${PN}"
	doenvd "99${PN}"
	cp -pPR ./{etc,opt,usr} "${D}"/ || die
	systemd_dounit lib/systemd/system/${PN}-scheduler.service
	systemd_enable_service multi-user.target ${PN}-scheduler.service
	dosym ../../../opt/${PN}/Fortitray.desktop /etc/xdg/autostart/Fortitray.desktop
	dosym ../../../opt/${PN}/Fortivpn.desktop /etc/xdg/autostart/Fortivpn.desktop
	dosym ../../opt/${PN}/gui/FortiClient-linux-x64/FortiClient /usr/bin/forticlient
}

pkg_postinst() {
	einfo
	einfo 'If you get a blank screen in the GUI, try restarting X or rebooting.'
	einfo
	xdg_pkg_postinst
}
