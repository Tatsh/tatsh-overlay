# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Install GTA III files from ISO or directories for use with re3."
HOMEPAGE="https://github.com/Tatsh/re3-installer"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="app-arch/unshield
	dev-libs/libcdio"
RDEPEND="${DEPEND}"
BDEPEND="test? (
	dev-util/cmocka
)"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_test() {
	ctest --output-on-failure --test-dir "${BUILD_DIR}/src" || die
}
