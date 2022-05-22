# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake flag-o-matic

DESCRIPTION="A new generation, open-source graphics plugin for N64 emulators."
HOMEPAGE="https://github.com/gonetz/GLideN64"
SHA="47b0de1ec1ae6f4591791c24c7ff3659982c9a29"
SRC_URI="https://github.com/gonetz/GLideN64/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/opengl
	media-libs/freetype
	media-libs/libglvnd
	media-libs/libpng
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/GLideN64-${SHA}"
CMAKE_USE_DIR="${S}/src"
CMAKE_BUILD_TYPE=Release

src_prepare() {
	cmake_src_prepare
	rm -rf src/GLideNHQ/inc
}

src_configure() {
	echo "#define PLUGIN_REVISION ${SHA}" > Revision.h
	echo "#define PLUGIN_REVISION_W L${SHA}" >> Revision.h
	local mycmakeargs=(
		-DCRC_OPT=ON
		-DVEC4_OPT=ON
		-DMUPENPLUSAPI=ON
		-DUSE_SYSTEM_LIBS=ON
	)
	cmake_src_configure
}

src_install() {
	insinto /usr/$(get_libdir)/mupen64plus
	doins "${BUILD_DIR}/plugin/Release/mupen64plus-video-GLideN64.so"
	einstalldocs
}
