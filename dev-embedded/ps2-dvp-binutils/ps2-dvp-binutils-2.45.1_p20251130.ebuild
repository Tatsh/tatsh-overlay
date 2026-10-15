# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic

DESCRIPTION="GNU binutils for the PlayStation 2 vector units (dvp)"
HOMEPAGE="https://github.com/ps2dev/binutils-gdb https://github.com/ps2dev/ps2toolchain-dvp"
SHA="3eb45ea37f0efd498d1de3cf9562de07197aefa8"
SRC_URI="https://github.com/ps2dev/binutils-gdb/archive/${SHA}.tar.gz -> binutils-gdb-${SHA}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SHA}"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="virtual/zlib:="
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/yacc
	app-alternatives/lex
	sys-apps/texinfo
"

src_configure() {
	# The dvp port of gas still relies on implicit declarations.
	append-cflags -Wno-implicit-function-declaration
	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target=dvp-scei-elf \
		--program-prefix=dvp- \
		--prefix="${EPREFIX}/usr" \
		--disable-gdb \
		--disable-gdbserver \
		--disable-nls \
		--disable-sim \
		--disable-werror \
		--with-python=no \
		--with-system-zlib \
		--without-debuginfod \
		--without-zstd
}

src_compile() {
	emake -C "${WORKDIR}/build"
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" install-strip
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}/usr/share/info" || die
}
