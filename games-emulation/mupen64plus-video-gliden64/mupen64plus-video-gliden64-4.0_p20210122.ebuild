# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="A new generation, open-source graphics plugin for N64 emulators."
HOMEPAGE="https://github.com/gonetz/GLideN64"
MY_SHA="85ad11bbddd8c774c0d430405e29026e5e4f3a50"
SRC_URI="https://github.com/gonetz/GLideN64/archive/${MY_SHA}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/opengl media-libs/freetype sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/GLideN64-${MY_SHA}"
CMAKE_USE_DIR="${S}/src"
CMAKE_BUILD_TYPE=Release

src_prepare() {
	cmake-utils_src_prepare
	rm -rf src/GLideNHQ/inc
}

src_configure() {
	echo "#define PLUGIN_REVISION ${MY_SHA}" > Revision.h
	echo "#define PLUGIN_REVISION_W L${MY_SHA}" >> Revision.h
	local mycmakeargs=(
		-DCRC_OPT=ON
		-DVEC4_OPT=ON
		-DMUPENPLUSAPI=ON
		-DUSE_SYSTEM_LIBS=ON
	)
	cmake-utils_src_configure
}

src_install() {
	insinto /usr/$(get_libdir)/mupen64plus
	doins "${BUILD_DIR}/plugin/Release/mupen64plus-video-GLideN64.so"
	einstalldocs
}
