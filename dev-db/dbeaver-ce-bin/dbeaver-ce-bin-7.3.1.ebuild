# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop

DESCRIPTION="Free universal database tool (community edition)."
HOMEPAGE="https://dbeaver.io/"
MY_PN="${PN%-bin*}"
SRC_URI="https://dbeaver.io/files/${PV}/${MY_PN}-${PV}-linux.gtk.x86_64.tar.gz"

LICENSE="Apache-2.0 EPL-1.0 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:3
	virtual/jre:="
DEPEND="${RDEPEND}"
BDEPEND=""

S="$WORKDIR"

MY_PN="${PN%-ce*}"
DOCS=( "${MY_PN}/readme.txt"
	   "${MY_PN}/licenses/"{commons,dbeaver}_license.txt
	   "${MY_PN}/licenses/jsch-license.txt"
	   "${MY_PN}/licenses/eclipse_license.html" )

src_prepare() {
	sed -e "s/^Icon=.*/Icon=${MY_PN}/" -i "${MY_PN}/${MY_PN}.desktop"
	sed -e "/WM_CLASS.*/d" -i "${MY_PN}/${MY_PN}.desktop"
	default
}

src_install() {
	dosym "${EPREFIX}/usr/share/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	doicon -s 128 "${MY_PN}/${MY_PN}.png"
	newicon "${MY_PN}/icon.xpm" "${MY_PN}.xpm"
	domenu "${MY_PN}/${MY_PN}.desktop"
	einstalldocs
	rm -fR "${MY_PN}/licenses"
	rm "${MY_PN}/${MY_PN}.desktop" \
		"${MY_PN}/${MY_PN}.png" "${MY_PN}/icon.xpm" "${MY_PN}/readme.txt"
	cp -a "$MY_PN" "${D}/usr/share/"
}
