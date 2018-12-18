# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A fork of Jongware's pngdefry (for converting iOS PNGs to normal ones)"
HOMEPAGE="http://www.jongware.com/pngdefry.html https://github.com/Tatsh/pngdefry"
MY_HASH="3d93d437991c5b5555502410a5cba2818102ca3a"
SRC_URI="https://github.com/Tatsh/pngdefry/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_HASH}/source"

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
}

src_install() {
	dobin pngdefry
	doman ../man/pngdefry.1
}
