# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"
LIBRETRO_COMMIT_SHA="22ba62e8a2e0fb7a8d05b4eec039e58de46924de"

inherit libretro-core

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API."
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
KEYWORDS="~amd64 ~x86 ~arm64"

LICENSE="GPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
		games-emulation/libretro-info"
IUSE="opengl vulkan cdrom"

src_compile() {
	MYEMAKEARGS=(
		"$(usex cdrom 'HAVE_CDROM=1' 'HAVE_CDROM=0')"
		HAVE_LIGHTREC=1
	)
	if  use opengl && use vulkan; then
		MYEMAKEARGS+=( "HAVE_HW=1" )
	else
		MYEMAKEARGS+=(
			"$(usex opengl 'HAVE_OPENGL=1' '')"
			"$(usex vulkan 'HAVE_VULKAN=1' '')"
		)
	fi
	libretro-core_src_compile
}
