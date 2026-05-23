# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Guitar Hero / Rock Band clone in C with SDL and OpenGL (archived project)."
HOMEPAGE="https://github.com/Tatsh/freeband"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/freeglut
	media-libs/libsdl[opengl,X]
	media-libs/libsndfile
	media-libs/portaudio
	media-libs/sdl-image
	media-libs/sdl-ttf
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-0001-cmakelists-accept-sdl-in-add.patch"
)
