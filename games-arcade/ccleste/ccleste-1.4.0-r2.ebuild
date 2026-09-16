# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs xdg

DESCRIPTION="Portable C port of Celeste Classic, originally a PICO-8 game."
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

PATCHES=( "${FILESDIR}/${PN}-data-dir.patch" )

src_compile() {
	emake CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -DCCLESTE_DATA_DIR=\\\"${EPREFIX}/usr/share/${PN}\\\" $($(tc-getPKG_CONFIG) --cflags sdl2 SDL2_mixer)" \
		LDFLAGS="${LDFLAGS} $($(tc-getPKG_CONFIG) --libs sdl2 SDL2_mixer) -lm"
}

src_install() {
	# The gamepad mapping file is written next to the working directory unless
	# CCLESTE_INPUT_CFG_PATH says otherwise, so a wrapper points it at the
	# configuration directory rather than wherever the game was started from.
	exeinto "/usr/libexec/${PN}"
	doexe "${PN}"

	cat > "${T}/${PN}" <<-EOF || die
		#!/bin/sh
		CCLESTE_CFG_DIR="\${XDG_CONFIG_HOME:-\${HOME}/.config}/${PN}"
		CCLESTE_INPUT_CFG_PATH="\${CCLESTE_INPUT_CFG_PATH:-\${CCLESTE_CFG_DIR}/input-cfg.txt}"
		export CCLESTE_INPUT_CFG_PATH
		mkdir -p "\$(dirname "\${CCLESTE_INPUT_CFG_PATH}")" || exit 1
		exec "${EPREFIX}/usr/libexec/${PN}/${PN}" "\$@"
	EOF
	dobin "${T}/${PN}"

	insinto "/usr/share/${PN}"
	doins data/* gamecontrollerdb.txt

	newicon icon.png "${PN}.png"
	make_desktop_entry "${PN}" "Celeste Classic" "${PN}" "Game;ArcadeGame"

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "The gamepad mapping file is written to input-cfg.txt in"
	elog "\${XDG_CONFIG_HOME}/${PN}. Set CCLESTE_INPUT_CFG_PATH to choose"
	elog "another path."
}
