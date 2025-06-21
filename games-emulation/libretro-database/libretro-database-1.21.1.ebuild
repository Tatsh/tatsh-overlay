# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Repository containing cheat code files, content data files, etc."
HOMEPAGE="https://github.com/libretro/libretro-database"

if [[ "${PV}" == *9999* ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/libretro/libretro-database"
else
	SRC_URI="https://github.com/libretro/libretro-database/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="CC-BY-SA-4.0"
SLOT="0"
