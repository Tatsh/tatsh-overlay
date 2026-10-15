# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="GNU binutils for the PlayStation 2 Emotion Engine (mips64r5900el-ps2-elf)"
HOMEPAGE="https://github.com/ps2dev/binutils-gdb https://github.com/ps2dev/ps2toolchain-ee"
SHA="616e51fa6ed9d1e8f4bda7d0087fac30c5398aa9"
SRC_URI="https://github.com/ps2dev/binutils-gdb/archive/${SHA}.tar.gz -> binutils-gdb-${SHA}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SHA}"

LICENSE="GPL-3+ LGPL-3+ gdb? ( GPL-2+ LGPL-2+ )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gdb"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="
	virtual/zlib:=
	gdb? (
		dev-libs/gmp:=
		dev-libs/mpfr:=
		sys-libs/ncurses:=
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/yacc
	app-alternatives/lex
	sys-apps/texinfo
"

TARGET="mips64r5900el-ps2-elf"

src_configure() {
	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		--prefix="${EPREFIX}/usr" \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--with-gdb-datadir="${EPREFIX}/usr/share/${TARGET}/gdb" \
		--disable-gdbserver \
		--disable-nls \
		--disable-separate-code \
		--disable-sim \
		--disable-werror \
		--with-python=no \
		--with-system-zlib \
		--without-debuginfod \
		--without-expat \
		--without-zstd \
		"$(use_enable gdb)"
}

src_compile() {
	emake -C "${WORKDIR}/build"
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" install-strip
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}"/usr/{lib*/bfd-plugins,share/info} || die
	if use gdb; then
		rm -r "${ED}/usr/include" || die
	fi
}
