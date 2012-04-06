# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils games mercurial

DESCRIPTION="Free open source emulator of Nintendo 64 based on original Mupen64 sources."
HOMEPAGE="https://code.google.com/p/mupen64plus"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/libpng
	media-libs/freetype:2
	sys-libs/zlib"
DEPEND="${RDEPEND}"

EHG_REPO_URI="https://bitbucket.org/richard42/mupen64plus-core"

src_compile() {
	cd ${S}/projects/unix
	emake V=1 all
}

src_install() {
	cd ${S}/projects/unix
	emake PREFIX="${D}${GAMES_PREFIX}" install
	prepgamesdirs
}
