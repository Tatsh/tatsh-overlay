# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/bsnes-mercury"
LIBRETRO_COMMIT_SHA="0f35d044bf2f2b879018a0500e676447e93a1db1"

inherit libretro-core

DESCRIPTION="Libretro fork of bsnes"
HOMEPAGE="https://github.com/libretro/bsnes-mercury"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# No tests provided
RESTRICT="test"

src_compile(){
	mymakeargs="profile=performance"
	libretro-core_src_compile
}
