# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Library to parse Apple's binarycookies format."
HOMEPAGE="https://github.com/Tatsh/bincookie"
SRC_URI="https://github.com/Tatsh/bincookie/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="doc test +tools"
RESTRICT="!test? ( test )"

BDEPEND="doc? ( app-doc/doxygen media-gfx/graphviz )
	test? ( dev-util/cmocka )"

src_configure() {
	mycmakeargs=(
		"-DWITH_DOCS=$(usex doc)"
		"-DWITH_EXAMPLES=$(usex tools)"
		"-DWITH_TESTS=$(usex test)"
	)
	cmake_src_configure
}
