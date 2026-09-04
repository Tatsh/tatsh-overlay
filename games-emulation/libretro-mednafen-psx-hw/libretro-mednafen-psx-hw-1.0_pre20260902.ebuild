# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/beetle-psx-libretro"
LIBRETRO_COMMIT_SHA="b4bca9f868176b157f021add3a96991aca12cb4d"

inherit libretro-core

DESCRIPTION="Standalone port/fork of Mednafen PSX to the Libretro API."
HOMEPAGE="https://github.com/libretro/beetle-psx-libretro"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="games-emulation/libretro-info"
DEPEND="media-libs/libglvnd"
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
