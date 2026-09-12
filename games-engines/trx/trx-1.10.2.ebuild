# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="TRX"

DESCRIPTION="Reimplementation of the Tomb Raider 1 and 2 engines."
HOMEPAGE="https://github.com/LostArtefacts/TRX"
SRC_URI="https://github.com/LostArtefacts/${MY_PN}/archive/refs/tags/${PN}-${PV}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# .gitmodules still lists libtrx, but it has been merged into src/trx and the
# only meson subproject left, dwarfstack, is Windows only.
RDEPEND="
	dev-lang/lua:5.4
	dev-libs/libpcre2:=
	media-libs/glew:=
	media-libs/libglvnd
	media-libs/libsdl2
	media-video/ffmpeg:=
	sys-libs/zlib:=
"
DEPEND="${RDEPEND}"

# meson.build lives in src/ rather than the top level.
EMESON_SOURCE="${S}/src"

src_configure() {
	local emesonargs=(
		# Gentoo's pkg-config files are versioned; upstream defaults to "lua".
		-Dlua_dep=lua5.4
		# Upstream defaults this on for its own release bundles. It pulls
		# Libs.private out of pkg-config, which here yields absolute library
		# paths that meson then passes as -l/usr/lib64/libX11.so.
		-Dstaticdeps=false
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# Upstream only installs its own data files on macOS.
	insinto "/usr/share/${PN}"
	doins -r data/trx/ship/.

	einstalldocs
}

pkg_postinst() {
	elog "${MY_PN} needs the data files from an original Tomb Raider install."
	elog "The files shipped with ${MY_PN} itself are in /usr/share/${PN}."
}
