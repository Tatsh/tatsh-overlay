# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vcs-snapshot

LIBRETRO_COMMIT_SHA="9230b1f24a6d0f28febe61711c0b255c4926b231"

DESCRIPTION="Vulkan/SPIR-V GPU shader collection for RetroArch (slang/slangp)"
HOMEPAGE="https://github.com/libretro/slang-shaders"
SRC_URI="https://github.com/libretro/slang-shaders/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 GPL-3 LGPL-3 MIT public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="games-emulation/libretro-info"

src_compile() {
	:
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
