# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic

DESCRIPTION="GCC, newlib and pthreads for the PlayStation 2 Emotion Engine"
HOMEPAGE="https://github.com/ps2dev/gcc https://github.com/ps2dev/newlib
https://github.com/ps2dev/pthread-embedded https://github.com/ps2dev/ps2toolchain-ee"
GCC_SHA="df77d03bc1bd5765b40de554918a5ff541202548"
NEWLIB_SHA="58fb6406408a541e0c826f47487315b485d4db56"
PTHREAD_SHA="b1746fd2b52d5aeafc1173761eb50e0958e8994b"
SRC_URI="
	https://github.com/ps2dev/gcc/archive/${GCC_SHA}.tar.gz -> gcc-${GCC_SHA}.tar.gz
	https://github.com/ps2dev/newlib/archive/${NEWLIB_SHA}.tar.gz -> newlib-${NEWLIB_SHA}.tar.gz
	https://github.com/ps2dev/pthread-embedded/archive/${PTHREAD_SHA}.tar.gz
		-> pthread-embedded-${PTHREAD_SHA}.tar.gz
"
S="${WORKDIR}/gcc-${GCC_SHA}"

LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 )
	NEWLIB LIBGLOSS GPL-2 LGPL-2.1+"
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
	~dev-embedded/ps2-ee-binutils-2.45.1_p20251130
"
BDEPEND="
	app-alternatives/lex
	sys-apps/texinfo
	~dev-embedded/ps2-ee-binutils-2.45.1_p20251130
"

TARGET="mips64r5900el-ps2-elf"
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="usr/lib/gcc/${TARGET}/* usr/${TARGET}/lib/*"

src_prepare() {
	sed -i -e 's/ -Werror\([[:space:]]\|$\)/\1/g' "${WORKDIR}/pthread-embedded-${PTHREAD_SHA}/platform/ps2/Makefile" || die
	default
}

# GCC needs newlib's headers and pthreads to build its runtime, and newlib needs a compiler, so
# all three are bootstrapped here as ps2toolchain-ee does: a C-only stage 1 compiler builds
# newlib, newlib-nano and pthread-embedded into a staging sysroot, then the full compiler is built
# against it.
src_configure() {
	filter-lto
	# libcody's u8"" literals break under hosts defaulting to C++20 or later.
	append-cxxflags -fno-char8_t
	export CXXFLAGS_FOR_BUILD="${CXXFLAGS}"
	export CFLAGS_FOR_TARGET="-O2 -gdwarf-2 -gz"
	export CXXFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET}"
}

ee_configure() {
	local src="${1}" dir="${2}"
	shift 2
	mkdir "${WORKDIR}/${dir}" || die
	cd "${WORKDIR}/${dir}" || die
	edo "${src}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		"$@"
}

gcc_configure() {
	# No --with-as/--with-ld: they make GCC assume GNU ld, which defaults MIPS to -msplit-addresses
	# and breaks srxfixup in ps2sdk.
	ee_configure "${S}" "$@" \
		--with-float=hard \
		--with-system-zlib \
		--without-isl \
		--without-zstd \
		--disable-libcc1 \
		--disable-libssp \
		--disable-multilib \
		--disable-nls \
		--disable-tls
}

src_compile() {
	local newlib="${WORKDIR}/newlib-${NEWLIB_SHA}" stage="${WORKDIR}/stage"
	local -x PATH="${stage}${EPREFIX}/usr/bin:${PATH}"

	gcc_configure build-stage1 \
		--prefix="${EPREFIX}/usr" \
		--enable-languages=c \
		--without-headers \
		--without-newlib \
		--disable-libatomic \
		--disable-libgcc \
		--disable-libgomp \
		--disable-libquadmath \
		--disable-shared \
		--disable-threads
	emake all-gcc
	emake DESTDIR="${stage}" install-gcc
	# Let the relocated stage 1 driver find the installed binutils through its tool directory.
	mkdir -p "${stage}${EPREFIX}/usr/${TARGET}" || die
	ln -s "${EPREFIX}/usr/${TARGET}/bin" "${stage}${EPREFIX}/usr/${TARGET}/bin" || die

	ee_configure "${newlib}" build-newlib \
		--prefix="${EPREFIX}/usr" \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--enable-newlib-io-c99-formats \
		--enable-newlib-multithread \
		--enable-newlib-retargetable-locking
	emake
	emake DESTDIR="${stage}" install-strip

	CFLAGS_FOR_TARGET="-DPREFER_SIZE_OVER_SPEED=1 -Os -gdwarf-2 -gz" \
		ee_configure "${newlib}" build-newlib-nano \
		--prefix="${EPREFIX}/usr" \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--disable-newlib-fseek-optimization \
		--disable-newlib-fvwrite-in-streamio \
		--disable-newlib-supplied-syscalls \
		--disable-newlib-unbuf-stream-opt \
		--disable-newlib-wide-orient \
		--disable-nls \
		--enable-lite-exit \
		--enable-newlib-global-atexit \
		--enable-newlib-multithread \
		--enable-newlib-nano-formatted-io \
		--enable-newlib-nano-malloc \
		--enable-newlib-reent-small \
		--enable-newlib-retargetable-locking
	emake
	emake DESTDIR="${WORKDIR}/nano" install-strip

	emake -C "${WORKDIR}/pthread-embedded-${PTHREAD_SHA}/platform/ps2" \
		DESTDIR="${stage}${EPREFIX}/usr/${TARGET}" all install

	gcc_configure build-stage2 \
		--prefix="${EPREFIX}/usr" \
		--enable-languages=c,c++ \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--with-build-sysroot="${stage}${EPREFIX}/usr/${TARGET}" \
		--with-native-system-header-dir=/include \
		--with-newlib \
		--disable-libquadmath \
		--enable-cxx-flags=-G0 \
		--enable-threads=posix \
		--with-python-dir="share/${TARGET}/python"
	emake all
}

src_install() {
	local lib sysroot="${ED}/usr/${TARGET}"

	emake -C "${WORKDIR}/build-newlib" DESTDIR="${D}" install-strip
	for lib in c g m; do
		cp "${WORKDIR}/nano${EPREFIX}/usr/${TARGET}/lib/lib${lib}.a" "${sysroot}/lib/lib${lib}_nano.a" || die
	done
	emake -C "${WORKDIR}/pthread-embedded-${PTHREAD_SHA}/platform/ps2" DESTDIR="${sysroot}" install
	emake -C "${WORKDIR}/build-stage2" DESTDIR="${D}" install-strip
	# ps2sdk provides the startup code.
	rm "${sysroot}/lib/crt0.o" || die
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}"/usr/share/{info,man/man7} || die
	find "${ED}/usr/libexec" -name '*.la' -delete || die
}
