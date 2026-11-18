# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_COMMIT_SHA="8cc97a529fc642ec9e40e2c2f7e7e5c53ea88428"

DESCRIPTION="Collection of overlay files for use with RetroArch"
HOMEPAGE="https://github.com/libretro/common-overlays"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/common-overlays.git"

	inherit git-r3
else
	inherit vcs-snapshot

	SRC_URI="https://github.com/libretro/common-overlays/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

src_compile() {
	:
}

src_install() {
	insinto "/usr/share/retroarch/overlay"
	doins -r ./*
}
