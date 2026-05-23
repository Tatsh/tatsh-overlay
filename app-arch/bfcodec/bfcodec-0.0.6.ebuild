# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Tools and a C/C++ library to manipulate BFCodec-encrypted content."
HOMEPAGE="https://github.com/Tatsh/bfcodec"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test +tools"
RESTRICT="!test? ( test )"

DEPEND="app-pda/libplist
	dev-libs/openssl"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTS=$(usex test)"
		"-DBUILD_TOOLS=$(usex tools)"
		-DCMAKE_SKIP_INSTALL_RPATH=ON
	)
	cmake_src_configure
}
