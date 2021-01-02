# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Library to parse Apple's binarycookies format."
HOMEPAGE="https://github.com/Tatsh/bincookie"
SRC_URI="https://github.com/Tatsh/bincookie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+tools"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e '27s/^if(DOXYGEN_FOUND.*/if(WITH_DOCS AND DOXYGEN_FOUND)/' \
		-i CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DWITH_EXAMPLES=$(usex tools)
	)
	cmake_src_configure
}
