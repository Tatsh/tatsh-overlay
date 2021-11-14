# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Cross platform audio library."
HOMEPAGE="https://github.com/mozilla/cubeb"
SHA="1099a3007817fa34c1f91e4710ec046021147bed"
SRC_URI="https://github.com/mozilla/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	sed -e '23s/.*/if(FALSE)/' -e 's/^add_sanitizers(.*//' \
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
