# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop qmake-utils

MY_HASH="ebad8c6bae19df3df7ac93f98c83a7498eac2eef"
DESCRIPTION="mupen64plus GUI that uses Qt."
HOMEPAGE="https://github.com/m64p/mupen64plus-gui"
SRC_URI="https://github.com/m64p/mupen64plus-gui/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl2
	sys-libs/zlib
	dev-qt/qtcore
	dev-qt/qtwidgets
	dev-qt/qtgui"
RDEPEND="${DEPEND} games-emulation/mupen64plus"
BDEPEND="media-gfx/icoutils"

S="${WORKDIR}/${PN}-${MY_HASH}"
DOCS=( README.md )

src_prepare() {
	sed -e 's:\(-L\)\?/usr/local/[^ ]\+::g' -i "${PN}.pro"
	icotool -x mupen64plus.ico
	default
}

src_configure() {
	eqmake5
}

src_install() {
	echo '#!/usr/bin/env bash' > "${PN}.sh"
	echo 'export export XDG_CURRENT_DESKTOP=qt' >> "${PN}.sh"
	echo "/usr/$(get_libdir)/${PN}/${PN} \$@" >> "${PN}.sh"
	exeinto "/usr/$(get_libdir)/${PN}"
	doexe "${PN}"
	newbin "${PN}.sh" "${PN}"
	einstalldocs

	for size in 16 24 32 48 256; do
		newicon -s "$size" "mupen64plus_"?"_${size}x${size}x32.png" "${PN}.png"
	done
	make_desktop_entry "${PN}" "${PN}" "${PN}"
}
