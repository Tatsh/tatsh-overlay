# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_COMMIT_SHA="ad6c4dab945d9a64f349b2fa0122cc8ad24be668"

DESCRIPTION="Libretro info files required for libretro cores"
HOMEPAGE="https://github.com/libretro/libretro-super"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/libretro/libretro-super.git"

	inherit git-r3
else
	inherit vcs-snapshot

	SRC_URI="https://github.com/libretro/libretro-super/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}.tar.gz"

	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

src_compile() {
	:
}

src_install() {
	insinto "/usr/share/libretro/info"
	doins dist/info/*.info
}
