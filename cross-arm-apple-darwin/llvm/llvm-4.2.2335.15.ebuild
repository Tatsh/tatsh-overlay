# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils

DESCRIPTION="Apple's LLVM GCC core."
HOMEPAGE="https://github.com/tatsh/xchain"
SRC_URI="http://opensource.apple.com/tarballs/llvmgcc42/llvmgcc42-2335.15.tar.gz"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
ECONF_SOURCE="../../llvmgcc42-2335.15/llvmCore"

RDEPEND=""
DEPEND="${RDEPEND}
	>=cross-arm-apple-darwin/sdk-4.2"

src_configure() {
	local target="arm-apple-darwin"
	mkdir -p "${S}"
	cd "${S}"
	
	mkdir llvm-obj
	cd llvm-obj
	econf \
		--target="${target}" \
		--prefix="/usr/${target}/usr" \
		--enable-optimized \
		--disable-assertions
}

src_compile() {
	cd "${S}/llvm-obj"
	emake VERBOSE=1 REQUIRES_RTTI=1 || die "emake failed"
}

src_install() {
	cd "${S}/llvm-obj"
	emake DESTDIR="${D}" install
	mkdir -p "${D}/usr/bin"
	for i in bugpoint \
		llc \
		lli \
		llvm-ar \
		llvm-as \
		llvm-bcanalyzer \
		llvmc \
		llvm-config \
		llvm-dis \
		llvm-extract \
		llvm-ld \
		llvm-link \
		llvm-nm \
		llvm-prof \
		llvm-ranlib \
		llvm-stub \
		opt \
		tblgen; do
		ln -s "${D}/usr/arm-apple-darwin/usr/bin/$i" "${D}/usr/bin/arm-apple-darwin-$i"
	done
}
