# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic

DESCRIPTION="GNU C compiler for the PlayStation 2 I/O processor (mipsel-none-elf)"
HOMEPAGE="https://gcc.gnu.org/ https://github.com/ps2dev/ps2toolchain-iop"
SRC_URI="mirror://gcc/gcc-${PV}/gcc-${PV}.tar.xz"
S="${WORKDIR}/gcc-${PV}"

LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 )"
SLOT="0"
KEYWORDS="~amd64"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="
	dev-libs/gmp:=
	dev-libs/mpc:=
	dev-libs/mpfr:=
	virtual/zlib:=
"
RDEPEND="
	${DEPEND}
	~dev-games/ps2-iop-binutils-2.45.1
"
BDEPEND="~dev-games/ps2-iop-binutils-2.45.1"

TARGET="mipsel-none-elf"
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="usr/lib/gcc/${TARGET}/*"

src_configure() {
	filter-lto
	# libcody's u8"" literals break under hosts defaulting to C++20 or later.
	append-cxxflags -fno-char8_t
	export CXXFLAGS_FOR_BUILD="${CXXFLAGS}"
	export CFLAGS_FOR_TARGET="-O2 -gdwarf-2 -gz"
	export CXXFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET}"
	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	# No --with-as/--with-ld: they make GCC assume GNU ld, which defaults MIPS to -msplit-addresses
	# and breaks srxfixup in ps2sdk.
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		--prefix="${EPREFIX}/usr" \
		--enable-languages=c,c++ \
		--with-float=soft \
		--with-headers=no \
		--with-system-zlib \
		--without-isl \
		--without-newlib \
		--without-zstd \
		--disable-decimal-float \
		--disable-libada \
		--disable-libatomic \
		--disable-libcc1 \
		--disable-libffi \
		--disable-libgomp \
		--disable-libquadmath \
		--disable-libssp \
		--disable-libstdcxx \
		--disable-libstdcxx-pch \
		--disable-multilib \
		--disable-nls \
		--disable-shared \
		--disable-target-libiberty \
		--disable-target-zlib \
		--disable-threads \
		--disable-tls
}

src_compile() {
	emake -C "${WORKDIR}/build" all
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" install-strip
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}"/usr/share/{info,man/man7} || die
	find "${ED}/usr/libexec" -name '*.la' -delete || die
}
