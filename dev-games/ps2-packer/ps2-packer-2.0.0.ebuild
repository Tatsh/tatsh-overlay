# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Executable packer for PlayStation 2 ELF files"
HOMEPAGE="https://github.com/ps2dev/ps2-packer"
SRC_URI="https://github.com/ps2dev/ps2-packer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
# The decompression stubs are PS2 executables.
RESTRICT="strip"
QA_PREBUILT="usr/share/ps2-packer/stub/*"

DEPEND="virtual/zlib:="
RDEPEND="${DEPEND}"
BDEPEND="dev-games/ps2sdk"

src_prepare() {
	sed -i -e 's/ -Werror\([[:space:]]\|$\)/\1/g' stub/{,lz4/,lzma/,lzo/,zlib/}Makefile || die
	default
}

ps2_packer_emake() {
	local -x PS2SDK="${EPREFIX}/usr/lib/ps2dev/ps2sdk"
	CPPFLAGS="${CFLAGS}" emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS} -ldl" PREFIX="${EPREFIX}/usr" "$@"
}

src_compile() {
	ps2_packer_emake
}

src_install() {
	ps2_packer_emake DESTDIR="${D}" install
	einstalldocs
}
