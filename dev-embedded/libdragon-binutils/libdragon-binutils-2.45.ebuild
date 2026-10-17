# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="GNU binutils for libdragon Nintendo 64 development (mips64-libdragon-elf)"
HOMEPAGE="https://www.gnu.org/software/binutils/ https://github.com/n64brew/libdragon"
SRC_URI="mirror://gnu/binutils/binutils-${PV}.tar.xz"
S="${WORKDIR}/binutils-${PV}"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="virtual/zlib:="
RDEPEND="${DEPEND}"

# A vendor field keeps this patched toolchain apart from a stock crossdev mips64-elf.
TARGET="mips64-libdragon-elf"

src_configure() {
	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target="${TARGET}" \
		--prefix="${EPREFIX}/usr" \
		--with-sysroot="${EPREFIX}/usr/${TARGET}" \
		--with-cpu=mips64vr4300 \
		--enable-targets=mips64-sgi-irix6 \
		--disable-gprofng \
		--disable-nls \
		--disable-werror \
		--with-system-zlib \
		--without-debuginfod \
		--without-msgpack \
		--without-zstd
}

src_compile() {
	emake -C "${WORKDIR}/build"
}

src_install() {
	emake -C "${WORKDIR}/build" DESTDIR="${D}" install-strip
	# Unprefixed files that would collide with the host toolchain.
	rm -r "${ED}"/usr/{lib*/bfd-plugins,share/info} || die
}
