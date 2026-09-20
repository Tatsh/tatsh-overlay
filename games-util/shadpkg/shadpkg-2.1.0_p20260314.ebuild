# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PN="ShadPKG"
# The last tag, v2.1.0, predates the whole decompiler and the current build
# system, so package a snapshot of main instead.
COMMIT="7a02c1e56b40477b26a660884deda1f3ca8d2eab"

DESCRIPTION="Tool to derive keys from and extract PlayStation 4 PKG files."
HOMEPAGE="https://github.com/seregonwar/ShadPKG"
SRC_URI="https://github.com/seregonwar/${MY_PN}/archive/${COMMIT}.tar.gz
	-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

# MIT for the project itself, GPL-2+ for the ~100 files under common/ and
# core/file_format/ taken from shadPS4.
LICENSE="GPL-2+ MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/capstone:=
	dev-libs/crypto++:=
	dev-libs/libfmt:=
	virtual/zlib:=
"
DEPEND="
	${RDEPEND}
	dev-cpp/nlohmann_json
"
BDEPEND="virtual/pkgconfig"

# Upstream only gets its dependencies through conan, which cannot run in the
# sandbox; this makes the build use the system ones.
PATCHES=( "${FILESDIR}/${PN}-no-conan.patch" )

src_configure() {
	# The GUI needs imgui with the glfw and OpenGL backends.
	local mycmakeargs=( -DBUILD_GUI=OFF )

	cmake_src_configure
}

src_install() {
	# Upstream defines no install rules.
	dobin "${BUILD_DIR}/shadpkg"

	einstalldocs
}
