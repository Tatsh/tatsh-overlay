# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop fcaps

DESCRIPTION="Macintosh emulator (updated fork)."
HOMEPAGE="https://github.com/kanjitalk755/macemu"
SHA="c4c153c49c6487c2fca3d009b2d9466eda71c5ef"
SRC_URI="https://github.com/kanjitalk755/macemu/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://sheepshaver.cebix.net/images/sheep.png -> ${PN}-icon.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jit"

DEPEND="dev-libs/glib
	media-libs/libsdl2
	x11-libs/gtk+
	x11-libs/libX11"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0001-fix-implicit.patch" )
S="${WORKDIR}/macemu-${SHA}/SheepShaver/src/Unix"
MAKEOPTS+=" -j1"
FILECAPS=( cap_sys_rawio bin/SheepShaver )

src_unpack() {
	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.png)
			;;
			*)
				unpack "${archive}"
			;;
		esac
	done
}

src_prepare() {
	default
	local AT_M4DIR="m4"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable jit) \
		--disable-sdl-static \
		--enable-sdl-audio \
		--enable-sdl-video \
		--with-bincue \
		--with-gtk \
		--without-esd \
		--without-sdl1
}

src_install() {
	emake DESTDIR="${D}" install
	newicon -s 32 "${DISTDIR}/${PN}-icon.png" "${PN}.png"
	make_desktop_entry SheepShaver SheepShaver "${PN}"
	dodoc ../../NEWS ../../../README.md
}
