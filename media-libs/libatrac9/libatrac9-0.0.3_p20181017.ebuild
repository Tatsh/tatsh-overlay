# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Library for decoding Sony's ATRAC9 audio format."
HOMEPAGE="https://github.com/Thealexbarney/LibAtrac9"
SHA="6a9e00f6c7abd74d037fd210b6670d3cdb313049"
SRC_URI="https://github.com/Thealexbarney/LibAtrac9/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/LibAtrac9-${SHA}/C"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	# The stock LFLAGS strip the library and set no SONAME.
	emake shared \
		CC="$(tc-getCC)" \
		SFLAGS="${CFLAGS}" \
		LFLAGS="-shared -Wl,-soname,libatrac9.so -Wl,--version-script=libatrac9.version ${LDFLAGS}"
}

src_install() {
	dolib.so bin/libatrac9.so
	doheader src/libatrac9.h
}
