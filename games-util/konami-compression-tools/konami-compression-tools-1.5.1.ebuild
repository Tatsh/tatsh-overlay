# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Compress and decompress Konami Compression variant 1 (LZKN1) data."
HOMEPAGE="https://github.com/vladikcomper/konami-compression-tools"
SRC_URI="https://github.com/vladikcomper/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default

	# Upstream never passes LDFLAGS when linking.
	sed -i -e 's|$(CC) $(CFLAGS) $^ -o bin/|$(CC) $(CFLAGS) $(LDFLAGS) $^ -o bin/|' \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -std=c99 -Iinclude"
}

src_test() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} -std=c99 -Iinclude" test
}

src_install() {
	dobin bin/lzkn
	einstalldocs
	docinto m68k
	dodoc m68k/*
}
