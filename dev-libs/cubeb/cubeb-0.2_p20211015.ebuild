# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Cross platform audio library."
HOMEPAGE="https://github.com/mozilla/cubeb"
MY_SHA="d512bfa07a327e0ae7e7aef892dcce01cbeaa67c"
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
