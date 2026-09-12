# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A simple NFO viewer."
HOMEPAGE="https://tatsh.github.io/tnfoview/ https://github.com/Tatsh/tnfoview"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# Qt6Test comes from qtbase itself, so the test suite needs nothing extra.
RDEPEND="dev-qt/qtbase:6[gui,widgets]"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		"-DBUILD_TESTS=$(usex test)"
	)

	cmake_src_configure
}
