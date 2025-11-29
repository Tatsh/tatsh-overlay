# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop fcaps rpm xdg

DESCRIPTION="Establish SSL VPN network access connection with F5 BIG-IP APM."
HOMEPAGE="https://www.f5.com/"
SRC_URI="https://vpn.f5.com/public/download/linux_${PN}.x86_64.rpm -> ${P}.x86_64.rpm"
S="${WORKDIR}"
LICENSE="F5-VPN"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

src_prepare() {
	rm opt/f5/vpn/.rpm || die
	rm -rf opt/f5/vpn/xdg-scripts || die
	mv opt/f5/vpn/com.* opt/f5/vpn/logos . || die
	chmod 0755 opt/f5/vpn/lib/*.so* || die
	default
}

src_install() {
	local bn item size
	for item in logos/*.png; do
		bn=$(basename "$item")
		size="${bn%x*}"
		newicon -s "${size}" "${item}" "${PN}.png"
	done
	keepdir /usr/local/lib/F5Networks/SSLVPN/var/run
	domenu "com.f5.${PN}.desktop"
	insinto /usr/share/dbus-1/services
	doins "com.f5.${PN}.service"
	mkdir -p "${D}/opt" || die
	cp -r opt/f5 "${D}/opt" || die
	fcaps cap_kill opt/f5/vpn/f5vpn
	fperms 4755 /opt/f5/vpn/svpn
}
