# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Multi-system emulator focusing on accuracy and preservation."
HOMEPAGE="https://github.com/ares-emulator/ares https://ares-emu.net/"
SRC_URI="https://github.com/ares-emulator/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/ares-emulator/ares-deps/releases/download/2026-04-23/ares-deps-linux-universal.tar.xz -> ${P}-deps.tar.xz"

LICENSE="MPL-2.0 MIT BSD public-domain ZLIB BSD-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/glib
	media-libs/alsa-lib
	media-libs/libao
	media-libs/libglvnd
	media-libs/libpulse
	media-libs/libsdl3
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
	mv "${WORKDIR}/ares-deps-linux-universal" .deps/ || die
	# _check_dependencies() only skips its own download when this marker matches
	# the hash in deps.json. Read it from there rather than repeating it here,
	# so bumping the bundle cannot leave the two disagreeing.
	local hash
	hash=$(sed -n 's/.*"linux-universal": "\([0-9a-f]\{64\}\)".*/\1/p' deps.json | head -n1)
	[[ -n ${hash} ]] || die 'Could not read the ares-deps hash from deps.json'
	printf '%s' "${hash}" > .deps/.dependency_prebuilt_universal.sha256 || die
	cmake_src_prepare
}
