# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 toolchain-funcs

DESCRIPTION="A fork of Jongware's pngdefry (for converting iOS PNGs to normal ones)"
HOMEPAGE="https://github.com/Tatsh/pngdefry"
EGIT_REPO_URI="git://github.com/Tatsh/pngdefry.git"
EGIT_COMMIT="875c4456ebdc2827a0f19a3ca4c39c46dc662e7e"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}/source"
	emake CC=$(tc-getCC) CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"
}

src_install() {
	cd "${S}/source"

	exeinto /usr/bin
	doexe pngdefry

	doman ../man/pngdefry.1
}
