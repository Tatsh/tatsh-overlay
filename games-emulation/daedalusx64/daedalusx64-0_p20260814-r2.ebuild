# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

MY_PN="daedalus"
MY_COMMIT="4f5c6fb045358044b64173fac619db5496cc2328"

DESCRIPTION="Nintendo 64 emulator."
HOMEPAGE="https://github.com/DaedalusX64/daedalus"
# The only release, 1.1.8 from 2019, is a PSP build. Development continues in
# the repository, so a snapshot is used.
SRC_URI="https://github.com/DaedalusX64/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libfmt:=
	media-libs/glew:=
	media-libs/libglvnd
	media-libs/libpng:=
	media-libs/libsdl2
	virtual/zlib
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fhs-xdg.patch"
	"${FILESDIR}/${P}-shader-load-return.patch"
	"${FILESDIR}/${P}-language-path.patch"
	"${FILESDIR}/${P}-font-path.patch"
	"${FILESDIR}/${P}-resource-path.patch"
	"${FILESDIR}/${P}-glew-no-glx-display.patch"
	"${FILESDIR}/${P}-draw-wrapped-line.patch"
	"${FILESDIR}/${P}-desktop-key-names.patch"
	"${FILESDIR}/${P}-pause-menu-key.patch"
	"${FILESDIR}/${P}-cheat-file-path.patch"
)

src_configure() {
	local mycmakeargs=(
		# Install into the prefix rather than one self contained directory,
		# and resolve writable paths through the XDG directories.
		-DDAEDALUS_FHS=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Upstream ships no Linux icon; this is the project artwork from the 3DS port.
	newicon -s 48 Source/SysCTR/Resources/icon.png "${PN}.png"
	make_desktop_entry daedalus DaedalusX64 "${PN}" Game
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Put ROMs in \${XDG_DATA_HOME}/DaedalusX64/Roms, by default"
	elog "~/.local/share/DaedalusX64/Roms. Saves and save states are written"
	elog "beside them."
	elog
	elog "F1 opens the in-game menu, F11 toggles fullscreen and Esc returns"
	elog "to the ROM list."
	elog
	elog "Preferences.ini and the controller configuration live in"
	elog "\${XDG_CONFIG_HOME}/DaedalusX64, and override the copies installed"
	elog "in /usr/share/DaedalusX64."
}
