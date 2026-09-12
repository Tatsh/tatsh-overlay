# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

MY_PN="OpenLara"

# Upstream has never tagged a release, so this is a snapshot of the default
# branch.
MY_COMMIT="e4ce52edec5a9a6ad22b69d08c687bf070e68876"

DESCRIPTION="Classic Tomb Raider open source engine."
HOMEPAGE="https://github.com/XProger/OpenLara"
SRC_URI="https://github.com/libretro/${MY_PN}/archive/${MY_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${MY_COMMIT}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-libs/libglvnd
	media-libs/libpulse
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

src_compile() {
	# Mirrors src/platform/nix/build.sh, which is upstream's desktop Linux
	# build. It has no Makefile, just this one command.
	# shellcheck disable=SC2046,SC2086
	edo $(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} \
		-std=c++11 -fno-exceptions -fno-rtti \
		-Wno-invalid-source-encoding -DNDEBUG -D_POSIX_THREADS \
		-D_POSIX_READER_WRITER_LOCKS \
		-Isrc \
		src/platform/nix/main.cpp \
		src/libs/stb_vorbis/stb_vorbis.c \
		src/libs/minimp3/minimp3.cpp \
		src/libs/tinf/tinflate.c \
		-o "${PN}" \
		-lX11 -lGL -lm -lpthread -lpulse-simple -lpulse
}

src_install() {
	dobin "${PN}"
	einstalldocs
}

pkg_postinst() {
	elog "${PN} needs the data files from a Tomb Raider installation. Run it"
	elog "from a directory containing them; saves and cache go to ~/.openlara."
}
