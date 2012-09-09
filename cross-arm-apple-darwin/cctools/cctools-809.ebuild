# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Apple's version of binutils for non-Darwin systems."
HOMEPAGE="http://opensource.apple.com/"
SRC_URI="http://opensource.apple.com/tarballs/${PN}/${PN}-809.tar.gz"
RESTRICT="mirror"

LICENSE="APSL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/gcc[objc,objc++]"
RDEPEND="${DEPEND}"

src_prepare() {
	# TODO
	# Figure out how to have LLVM support
	# Figure out the correct way to add the type definition
	epatch "${FILESDIR}"/${PN}-809-ar-time-and-format.patch
	epatch "${FILESDIR}"/${PN}-809-force-arm-thread-state.patch
	epatch "${FILESDIR}"/${PN}-809-ld.patch
	epatch "${FILESDIR}"/${PN}-809-libtool.patch
	epatch "${FILESDIR}"/${PN}-809-ppc64-thread-state.patch
	epatch "${FILESDIR}"/${PN}-809-private-extern.patch
	epatch "${FILESDIR}"/${PN}-809-remove-llvm-support.patch
	epatch "${FILESDIR}"/${PN}-809-add-autoconf.patch.gz
}

src_configure() {
	chmod +x configure
	local target="arm-apple-darwin"

	# No optimisations!
	filter-flags -fomit-frame-pointer
	filter-flags -pipe
	filter-flags -O*
	filter-flags -mmmx*
	filter-flags -msse*
	filter-flags -march=*
	replace-cpu-flags

	# Must be built in 32-bit mode
	append-flags "-m32 -w"
	append-ldflags "-m32"

	econf --target=${target}
}

src_install() {
	emake DESTDIR="${D}" install
	mv "${D}/usr/bin/arm-apple-darwin-ld" "${D}/usr/bin/arm-apple-darwin-ld.old"
}

