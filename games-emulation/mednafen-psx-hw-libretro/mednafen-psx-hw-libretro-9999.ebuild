# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"

inherit libretro-core

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API."
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
IUSE="opengl vulkan cdrom"

src_compile() {
	myemakeargs=(
		$(usex cdrom "HAVE_CDROM=1" "HAVE_CDROM=0")
		HAVE_LIGHTREC=1
	)
	if  use opengl && use vulkan; then
		myemakeargs+=( "HAVE_HW=1" )
	else
		myemakeargs+=(
			$(usex opengl "HAVE_OPENGL=1" "")
			$(usex vulkan "HAVE_VULKAN=1" "")
		)
	fi

	libretro-core_src_compile
}
