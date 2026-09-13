# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs xdg

DESCRIPTION="C source port of Celeste Classic for the PICO-8."
HOMEPAGE="https://github.com/lemon32767/ccleste"
SRC_URI="https://github.com/lemon32767/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

# Upstream ships no licence file and states no terms anywhere in the repository.
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

DEPEND="
	media-libs/libsdl2[video]
	media-libs/sdl2-mixer[vorbis]
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-data-dir.patch" )

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -DCCLESTE_DATA_DIR=\\\"${EPREFIX}/usr/share/${PN}\\\" $($(tc-getPKG_CONFIG) --cflags sdl2 SDL2_mixer)" \
		LDFLAGS="${LDFLAGS} $($(tc-getPKG_CONFIG) --libs sdl2 SDL2_mixer) -lm"
}

src_install() {
	dobin "${PN}"

	insinto "/usr/share/${PN}"
	doins data/* gamecontrollerdb.txt

	newicon icon.png "${PN}.png"
	make_desktop_entry "${PN}" "Celeste Classic" "${PN}" "Game;ArcadeGame"

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "The gamepad mapping file is written to ccleste-input-cfg.txt in the"
	elog "current directory. Set CCLESTE_INPUT_CFG_PATH to choose another path."
}
