# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="Web debugging proxy application."
HOMEPAGE="https://www.charlesproxy.com/"
SRC_URI="https://www.charlesproxy.com/assets/release/${PV}/${PN}-proxy-${PV}_x86_64.tar.gz"

LICENSE="Charles Apache-2.0 MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jre:17"
RESTRICT="strip"

S="${WORKDIR}/charles"
PATCHES=( "${FILESDIR}/${PN}-misc.patch" )

src_prepare() {
	# Collides with Wireshark
	find . -name application-vnd.tcpdump.pcap.png -delete
	rm -R lib/jdk || die
	sed -e "s/^Icon=.*/Icon=${PN}-proxy/" -i "etc/${PN}-proxy5.desktop" || die
	default
	sed -e "s/@EPREFIX@/${EPREFIX}/g" -i "bin/${PN}"
}

src_install() {
	dobin "bin/${PN}" bin/add-to-java-cacerts.sh
	insinto "/usr/share/java/${PN}"
	doins lib/*.jar
	insinto /usr/share/icons/hicolor
	doins -r icon/*
	domenu etc/*.desktop
	insinto /usr/share/mime/packages
	doins etc/mime/*.xml
	einstalldocs
}
