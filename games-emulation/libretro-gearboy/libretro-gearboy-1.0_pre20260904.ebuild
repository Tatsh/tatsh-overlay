# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/Gearboy"
LIBRETRO_COMMIT_SHA="a83b0c5d42b881e9490734c1fd7942f841b91895"
inherit libretro-core

DESCRIPTION="Gearboy libretro port (Nintendo Game Boy / Game Boy Color)"
HOMEPAGE="https://github.com/libretro/Gearboy"
# Keep S at the repo root so patches that touch both platforms/libretro/
# and src/ apply with -p1. Build from the libretro subdir via src_compile.
S="${WORKDIR}/Gearboy-${LIBRETRO_COMMIT_SHA}"
LIBRETRO_CORE_LIB_FILE=( "${S}/platforms/libretro/gearboy_libretro.so" )
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/miniz"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-libretro-cartridge.cpp-add-s.patch"
)

MYEMAKEARGS=( "SYSTEM_MINIZ=1" )

src_compile() {
	cd "${S}/platforms/libretro" || die
	libretro-core_src_compile
}
