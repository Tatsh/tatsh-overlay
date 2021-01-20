# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop eutils

DESCRIPTION="Free universal database tool (community edition)."
HOMEPAGE="https://dbeaver.io/"
MY_PN="${PN%-bin*}-ce"
SRC_URI="https://dbeaver.io/files/${PV}/${MY_PN}-${PV}-linux.gtk.x86_64.tar.gz"

LICENSE="Apache-2.0 EPL-1.0 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}"
BDEPEND=""

MY_PN="${PN%-bin*}"
S="${WORKDIR}/${MY_PN}"

src_prepare() {
	rm -fR licenses
	# FIXME add virtual/jre:= to RDEPEND when this can be done
	# rm -fR jre
	sed -e "s/^Icon=.*/Icon=${MY_PN}/" -i "${MY_PN}.desktop"
	sed -e "/WM_CLASS.*/d" -i "${MY_PN}.desktop"
	default
}

src_install() {
	doicon -s 128 "${MY_PN}.png"
	newicon icon.xpm "${MY_PN}.xpm"
	domenu "${MY_PN}.desktop"
	einstalldocs
	rm "${MY_PN}.desktop" "${MY_PN}.png" icon.xpm readme.txt
	insinto "/opt/${MY_PN}"
	doins -r *
	fperms 0755 "/opt/${MY_PN}/${MY_PN}" "/opt/${MY_PN}/jre/bin/"*
	make_wrapper "${MY_PN}" "/opt/${MY_PN}/${MY_PN}"
}
