# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Cross platform audio library."
HOMEPAGE="https://github.com/kinetiknz/cubeb"
MY_SHA="9beb8ed0c91f1b6ed7769d2c28c94a1d78b6c6f1"
SRC_URI="https://github.com/mozilla/${PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${MY_SHA}"

src_prepare() {
	sed -e '25s/.*/if(FALSE)/' -e 's/^add_sanitizers(.*//' \
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
