# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo flag-o-matic

# The fourth component is the CI run of the matching upstream toolchain release.
GCC_PV="$(ver_cut 1-3)"
BINUTILS_PV="2.45"
NEWLIB_PV="4.4.0.20231231"
DESCRIPTION="GCC and newlib for libdragon Nintendo 64 development (mips64-libdragon-elf)"
HOMEPAGE="https://gcc.gnu.org/ https://sourceware.org/newlib/ https://github.com/n64brew/libdragon"
SRC_URI="
	mirror://gcc/gcc-${GCC_PV}/gcc-${GCC_PV}.tar.xz
	https://sourceware.org/pub/newlib/newlib-${NEWLIB_PV}.tar.gz
"
S="${WORKDIR}/gcc-${GCC_PV}"

LICENSE="GPL-3+ LGPL-3+ || ( GPL-3+ libgcc libstdc++ gcc-runtime-library-exception-3.1 )
	NEWLIB LIBGLOSS GPL-2"
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
	~dev-embedded/libdragon-binutils-${BINUTILS_PV}
"
BDEPEND="~dev-embedded/libdragon-binutils-${BINUTILS_PV}"

# libdragon's VR4300 errata fix and N64 multilib set, from the preview branch's
# tools/build-toolchain.sh.
PATCHES=( "${FILESDIR}/${PN}-n64.patch" )

TARGET="mips64-libdragon-elf"
# Bare-metal target objects carry no .note.GNU-stack section.
QA_EXECSTACK="usr/lib/gcc/${TARGET}/* usr/${TARGET}/lib/*"

src_configure() {
	filter-lto
	export CXXFLAGS_FOR_BUILD="${CXXFLAGS}"
	# Without these, the host CFLAGS would be used for the MIPS target libraries.
	export CFLAGS_FOR_TARGET="-O2 -g"
	export CXXFLAGS_FOR_TARGET="${CFLAGS_FOR_TARGET}"
}

# GCC's C++ runtime needs newlib's headers and newlib needs a compiler, so this follows
# tools/build-toolchain.sh: build the compiler and libgcc, install them into a staging sysroot,
# build newlib with them, then finish the target libraries against that sysroot.
src_compile() {
	local stage="${WORKDIR}/stage"
	local -x PATH="${stage}${EPREFIX}/usr/bin:${PATH}"

	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	# No --with-as/--with-ld: they make GCC assume GNU ld, which changes MIPS code generation
	# defaults.
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		--prefix="${EPREFIX}/usr" \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--with-build-sysroot="${stage}${EPREFIX}/usr/${TARGET}" \
		--with-native-system-header-dir=/include \
		--with-arch=vr4300 \
		--with-tune=vr4300 \
		--enable-languages=c,c++ \
		--enable-multilib \
		--with-newlib \
		--with-python-dir="share/${TARGET}/python" \
		--with-system-zlib \
		--without-headers \
		--without-isl \
		--without-zstd \
		--disable-libcc1 \
		--disable-libquadmath \
		--disable-libssp \
		--disable-nls \
		--disable-shared \
		--disable-werror
	emake all-gcc all-target-libgcc
	emake DESTDIR="${stage}" install-gcc install-target-libgcc
	# Let the relocated driver find the installed binutils through its tool directory.
	mkdir -p "${stage}${EPREFIX}/usr/${TARGET}" || die
	ln -s "${EPREFIX}/usr/${TARGET}/bin" "${stage}${EPREFIX}/usr/${TARGET}/bin" || die

	mkdir "${WORKDIR}/build-newlib" || die
	cd "${WORKDIR}/build-newlib" || die
	CFLAGS_FOR_TARGET="-DHAVE_ASSERT_FUNC -O2 -fpermissive" CC_FOR_TARGET="${TARGET}-gcc" \
		edo "${WORKDIR}/newlib-${NEWLIB_PV}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		--prefix="${EPREFIX}/usr" \
		--with-cpu=mips64vr4300 \
		--disable-libssp \
		--disable-werror \
		--enable-newlib-io-c99-formats \
		--enable-newlib-multithread \
		--enable-newlib-retargetable-locking
	emake
	emake DESTDIR="${stage}" install

	emake -C "${WORKDIR}/build" all
}

src_install() {
	emake -C "${WORKDIR}/build-newlib" DESTDIR="${D}" install
	emake -C "${WORKDIR}/build" DESTDIR="${D}" install-strip
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}"/usr/share/{info,man/man7} || die
	find "${ED}/usr/libexec" -name '*.la' -delete || die
	# Identifies the toolchain to libdragon, as build-toolchain.sh does.
	insinto "/usr/${TARGET}/include"
	newins - toolchain.version <<-EOF2
		{
		  "host": "${CHOST}",
		  "binutils": "${BINUTILS_PV}",
		  "gcc": "${GCC_PV}",
		  "newlib": "${NEWLIB_PV}"
		}
	EOF2
}
