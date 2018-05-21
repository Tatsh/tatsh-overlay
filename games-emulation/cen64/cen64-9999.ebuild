# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Cycle-accurate Nintendo 64 emulator."
HOMEPAGE="https://github.com/tj90241/cen64"
EGIT_REPO_URI="https://github.com/tj90241/cen64"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="virtual/opengl
>=media-libs/openal-1.15.1-r2"
RDEPEND="${DEPEND}"

src_configure () {
	mycmakeargs=()
	use debug && mycmakeargs=(-DDEBUG_MMIO_REGISTER_ACCESS=ON)
	cmake-utils_src_configure
}

src_install () {
	dobin "${BUILD_DIR}/cen64" || die "dobin cen64 failed"
}
