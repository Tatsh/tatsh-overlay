# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Single file executable that provides a complete Tcl and Tk runtime."
HOMEPAGE="https://github.com/stiefel40k/kitgen"
MY_PV="${PV:0:5}-${PV:6}"
MY_PN="kitgen"
TCL_VERSION="8.6.11"
TK_VERSION="8.6.11.1"
SRC_URI="https://github.com/stiefel40k/kitgen/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://prdownloads.sourceforge.net/tcl/tk${TK_VERSION}-src.tar.gz -> ${PN}-tk-${TK_VERSION}.tar.gz
	https://prdownloads.sourceforge.net/tcl/tcl${TCL_VERSION}-src.tar.gz -> ${PN}-tcl-${TCL_VERSION}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"
BDEPEND="x11-base/xorg-proto
	x11-libs/libX11
	dev-libs/ucl"

S="${WORKDIR}/${MY_PN}-${MY_PV}"
RESTRICT="strip"

src_prepare() {
	mkdir build || die
	mv "../tcl${TCL_VERSION}" build/tcl || die
	mv "../tk${TK_VERSION:0:6}" build/tk || die
	sed -re '/.*\(\$\(LDCONFIG\) \|\| true\).*/d' -i 8.x/zlib/Makefile.in || die
	default
}

src_configure() {
	export B64=b64 options="thread allenc cli dyn"
	./config.sh build/kit-large thread allenc cli dyn b64
}

src_compile() {
	export B64=b64 options="thread allenc cli dyn"
	cd build/kit-large || die
	unset A
	emake UPX=echo STRIP=echo
}

src_install() {
	dobin build/kit-large/{tcl,}kit-*
	dosym tclkit-cli /usr/bin/tclkit
}
