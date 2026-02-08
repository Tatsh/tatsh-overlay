# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A resource compiler in a single CMake script."
HOMEPAGE="https://github.com/vector-of-bool/cmrc"
MY_PN="cmrc"
SRC_URI="https://github.com/vector-of-bool/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/${PN}-40-install.patch" )

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTS=$(usex test)"
		-DCMAKE_POLICY_VERSION_MINIMUM=3.12
	)
	cmake_src_configure
}
