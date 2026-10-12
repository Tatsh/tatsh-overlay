# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="File dialog library with C and C++ bindings, based on nativefiledialog"
HOMEPAGE="https://github.com/btzy/nativefiledialog-extended"
SRC_URI="https://github.com/btzy/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="test wayland"
RESTRICT="!test? ( test )"

RDEPEND="x11-libs/gtk+:3
	wayland? ( dev-libs/wayland )"
DEPEND="${RDEPEND}
	dev-libs/glib
	wayland? ( dev-libs/wayland-protocols )"
BDEPEND="wayland? ( dev-util/wayland-scanner )"

src_prepare() {
	sed -e "s|DESTINATION lib|DESTINATION $(get_libdir)|g" -i src/CMakeLists.txt || die
	# The wayland-protocols git submodule is absent from the release archive.
	sed -e "s|\${CMAKE_CURRENT_SOURCE_DIR}/../3ps/wayland-protocols|${ESYSROOT}/usr/share/wayland-protocols|" \
		-i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DNFD_BUILD_TESTS=$(usex test)"
		"-DNFD_WAYLAND=$(usex wayland)"
	)
	cmake_src_configure
}
