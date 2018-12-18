# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
if [[ "$PV" = 9999 ]]; then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="https://github.com/tj90241/cen64"
else
	KEYWORDS="~amd64 ~x86"
	MY_HASH="a8779878e9cb4c81c00e72b21f1494e05e083a4e"
	SRC_URI="https://github.com/tj90241/cen64/archive/${MY_HASH}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_HASH}"
fi
inherit cmake-utils "$GIT_ECLASS"

DESCRIPTION="Cycle-accurate Nintendo 64 emulator."
HOMEPAGE="https://github.com/tj90241/cen64"

LICENSE="BSD-3"
SLOT="0"
IUSE="debug"

DEPEND="virtual/opengl
	>=media-libs/openal-1.15.1-r2
	virtual/libiconv"
RDEPEND="${DEPEND}"

DOCS=( CONTRIBUTORS LICENSE README.md VERSION )

src_configure () {
	mycmakeargs=()
	use debug && mycmakeargs=(-DDEBUG_MMIO_REGISTER_ACCESS=ON)
	cmake-utils_src_configure
}

src_install () {
	dobin "${BUILD_DIR}/cen64" || die "dobin cen64 failed"
	einstalldocs
}
