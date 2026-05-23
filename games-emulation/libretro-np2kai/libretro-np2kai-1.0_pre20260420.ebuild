# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/np2kai"
LIBRETRO_COMMIT_SHA="54ec39f50d197cc02909cd4fd2a8591bb38651b0"
inherit libretro-core

DESCRIPTION="Neko Project II kai libretro port (NEC PC-9801 / PC-9821)"
HOMEPAGE="https://github.com/libretro/np2kai"
S="${WORKDIR}/NP2kai-${LIBRETRO_COMMIT_SHA}/sdl"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"

PATCHES=(
	"${FILESDIR}/${PN}-0001-sdl-makefile.libretro-suppre.patch"
)
