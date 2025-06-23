# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/mupen64plus-libretro-nx"
LIBRETRO_COMMIT_SHA="0346d3ef26016bb4de604cf918d004bd791447ee"
LIBRETRO_CORE_NAME="mupen64plus_next"

inherit libretro-core

DESCRIPTION="Improved mupen64plus libretro core reimplementation"
HOMEPAGE="https://github.com/libretro/mupen64plus-libretro-nx"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="rpi rpi2 rpi3 rpi3_64 rpi4 rpi4_64 gles2 gles3"

RDEPEND="media-libs/mesa:0=
	media-libs/libpng:0="
DEPEND="${RDEPEND}
	dev-lang/nasm:0=
	games-emulation/libretro-info"

src_compile() {
	MYEMAKEARGS=(
		"$(usex amd64 'ARCH=x86_64 WITH_DYNAREC=x86_64 HAVE_PARALLEL_RDP=1 HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1 HAVE_LLE=1' '')"
		"$(usex x86 'ARCH=x86 WITH_DYNAREC=x86 HAVE_PARALLEL_RDP=1 HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1 HAVE_LLE=1' '')"
		"$(usex arm 'ARCH=arm WITH_DYNAREC=arm' '')"
		"$(usex arm64 'ARCH=aarch64 WITH_DYNAREC=aarch64' '')"
		"$(usex rpi 'platform=rpi' '')"
		"$(usex rpi2 'platform=rpi2' '')"
		"$(usex rpi3 'platform=rpi3' '')"
		"$(usex rpi3_64 'platform=rpi3_64' '')"
		"$(usex rpi4 'platform=rpi4' '')"
		"$(usex rpi4_64 'platform=rpi4_64' '')"
		"$(usex gles2 'GLES=1 FORCE_GLES=1' 'GLES=0 FORCE_GLES=0')"
		"$(usex gles3 'GLES3=1 FORCE_GLES3=1' 'GLES3=0 FORCE_GLES3=0')"
	)
	libretro-core_src_compile
}
