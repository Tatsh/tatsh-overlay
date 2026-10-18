# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

DESCRIPTION="GNU binutils for the PlayStation 2 I/O processor (mipsel-none-elf)"
HOMEPAGE="https://www.gnu.org/software/binutils/ https://github.com/ps2dev/ps2toolchain-iop"
SRC_URI="mirror://gnu/binutils/binutils-${PV}.tar.xz"
S="${WORKDIR}/binutils-${PV}"

LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
# Target objects must not be touched by the host strip.
RESTRICT="strip test"

DEPEND="virtual/zlib:="
RDEPEND="${DEPEND}"

src_configure() {
	mkdir "${WORKDIR}/build" || die
	cd "${WORKDIR}/build" || die
	edo "${S}/configure" \
		--build="${CBUILD:-${CHOST}}" \
		--host="${CHOST}" \
		--target=mipsel-none-elf \
		--prefix="${EPREFIX}/usr" \
		--disable-gprofng \
		--disable-nls \
		--disable-separate-code \
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
	rm -r "${ED}"/usr/{lib*/bfd-plugins,share/info} || die
}
