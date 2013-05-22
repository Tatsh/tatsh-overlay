# kate: replace-tabs false;
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils games mercurial

DESCRIPTION="Video plugin for Mupen64plus utilizing OpenGL."
HOMEPAGE="https://code.google.com/p/mupen64plus"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/libpng"
DEPEND="${RDEPEND}
	games-emulation/mupen64plus-core"

EHG_REPO_URI="https://bitbucket.org/richard42/mupen64plus-video-rice"

src_compile() {
	cd ${S}/projects/unix
	emake V=1 OPTFLAGS="" APIDIR="${GAMES_PREFIX}/include/mupen64plus" all
}

src_install() {
	cd ${S}/projects/unix
	emake V=1 \
		INSTALL_STRIP_FLAG="" \
		APIDIR="${GAMES_PREFIX}/include/mupen64plus" \
		PREFIX="${D}${GAMES_PREFIX}" \
		install
	prepgamesdirs
}
