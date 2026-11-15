# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="cmrc"
DESCRIPTION="A resource compiler in a single CMake script"
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
SRC_URI="https://github.com/vector-of-bool/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-build/cmake"

src_prepare() {
	# CMake 4 rejects minimums below 3.5, breaking every project that includes
	# CMakeRC.cmake. Upstream master uses 3.12.
	sed -i 's/^cmake_minimum_required(VERSION 3\.3)$/cmake_minimum_required(VERSION 3.12)/' \
		CMakeRC.cmake || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( -DBUILD_TESTS="$(usex test)" )
	cmake_src_configure
}

src_install() {
	insinto /usr/share/cmake/cmakerc
	newins CMakeRC.cmake cmakerc-config.cmake
}
