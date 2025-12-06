# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop wrapper

DESCRIPTION="Reimplementation of Super Mario World."
HOMEPAGE="https://github.com/snesrev/smw"
SRC_URI="https://github.com/snesrev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	smw.sfc"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch"

DEPEND="media-libs/libsdl2[joystick,opengl,sound,video]"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-use-xdg-paths-for-config-and.patch"
)

pkg_nofetch() {
	elog "Place a copy of Super Mario World (US) in DISTDIR named 'smw.sfc'."
}

src_prepare() {
	cp "${DISTDIR}/smw.sfc" . || die
	default
}

src_install() {
	exeinto "/usr/share/${PN}"
	doexe "${PN}"
	insinto "/usr/share/${PN}"
	doins "${PN}_assets.dat" "${PN}.ini"
	make_wrapper "${PN}" "/usr/share/${PN}/${PN}" "/usr/share/${PN}"
	make_desktop_entry "${PN}" "${PN}"
}
