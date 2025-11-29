# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="JAR and Android APK reverse engineering suite."
HOMEPAGE="https://bytecodeviewer.com/"
MY_PN="Bytecode-Viewer"
PNB="${PN%-*}"
PB="${PNB}-${PV}"
SRC_URI="https://github.com/Konloch/${PNB}/releases/download/v${PV}/${MY_PN}-${PV}.jar -> ${PB}.jar
	https://raw.githubusercontent.com/Konloch/${PNB}/v${PV}/BCV%20Icon.png -> ${PB}-icon.png"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jre:17"

src_install() {
	insinto "/usr/share/${PNB}"
	doins "${DISTDIR}/${PB}.jar"
	newicon "${DISTDIR}/${PB}-icon.png" "${PNB}.png"
	make_wrapper "${PNB}"  "java -jar ${EPREFIX}/usr/share/${PNB}/${PB}.jar"
	make_desktop_entry "${PNB}" "${PNB}" "${PNB}"
}
