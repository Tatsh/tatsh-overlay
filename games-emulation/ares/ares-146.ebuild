# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A cross-platform, open source, multi-system emulator, focusing on accuracy and preservation."
HOMEPAGE="https://github.com/ares-emulator/ares https://ares-emu.net/"
SRC_URI="https://github.com/ares-emulator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ares-emulator/ares-deps/releases/download/2025-07-14/ares-deps-linux-universal.tar.xz -> ${P}-deps.tar.xz"

LICENSE="MPL-2.0 MIT BSD public-domain ZLIB BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/glib
	media-libs/alsa-lib
	media-libs/libao
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libsdl2
	media-libs/openal
	virtual/udev
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	x11-libs/libX11
	x11-libs/libXrandr
	x11-libs/pango"
RDEPEND="${DEPEND}"

src_prepare() {
	mkdir -p .deps || die
	cp "${DISTDIR}/${P}-deps.tar.xz" .deps/ares-deps-linux-universal.tar.xz || die
	mv "${WORKDIR}/ares-deps-linux-universal" .deps/ || die
	printf '%s' c4679098d2a9cd51c1cacb70555e302e78501e481dcaabc060ca16d6f620128f > .deps/.dependency_prebuilt_universal.sha256 || die
	cmake_src_prepare
}
