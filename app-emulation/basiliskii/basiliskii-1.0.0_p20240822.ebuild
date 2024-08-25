# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools desktop

DESCRIPTION="68k Macintosh emulator (updated fork)."
HOMEPAGE="https://github.com/kanjitalk755/macemu"
SHA="e517d73f0cd2e4fed637717164e1496374618115"
SRC_URI="https://github.com/kanjitalk755/macemu/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://basilisk.cebix.net/images/apple.png -> ${PN}-icon.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+jit jit-debug"

DEPEND="dev-libs/glib
	media-libs/libsdl2
	x11-libs/gtk+:2
	x11-libs/libX11"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-fixes.patch" )
S="${WORKDIR}/macemu-${SHA}/BasiliskII/src/Unix"
MAKEOPTS+=" -j1"

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
		"$(use_enable jit jit-compiler)" \
		"$(use_enable jit-debug)" \
		--disable-vosf \
		--enable-fpe=ieee \
		--enable-sdl-audio \
		--enable-sdl-video \
		--with-bincue \
		--with-gtk \
		--without-esd
}

src_install() {
	emake DESTDIR="${D}" install
	newicon -s 32 "${DISTDIR}/${PN}-icon.png" "${PN}.png"
	make_desktop_entry BasiliskII BasiliskII "${PN}"
	dodoc ../../TECH ../../ChangeLog ../../TODO ../../../README.md
}
