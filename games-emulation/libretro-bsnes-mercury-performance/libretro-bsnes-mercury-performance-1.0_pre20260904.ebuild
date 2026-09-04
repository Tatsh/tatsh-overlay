# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_REPO_NAME="libretro/bsnes-mercury"
LIBRETRO_COMMIT_SHA="79d7f9de218b6ffa65a80bbdc5828532bc239232"

inherit libretro-core

DESCRIPTION="Libretro fork of bsnes"
HOMEPAGE="https://github.com/libretro/bsnes-mercury"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
# No tests provided
RESTRICT="test"

src_compile(){
	mymakeargs="profile=performance"
	libretro-core_src_compile
}
