# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Cross platform audio library."
HOMEPAGE="https://github.com/mozilla/cubeb"
SHA="75d9d125ee655ef80f3bfcd97ae5a805931042b8"
SRC_URI="https://github.com/mozilla/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/speexdsp"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -r \
		-e 's/if\(USE_SANITIZERS\)/if(FALSE)/' \
		-e 's/^add_sanitizers\(.*//' \
		-i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=OFF
		-DBUILD_TOOLS=OFF
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}
