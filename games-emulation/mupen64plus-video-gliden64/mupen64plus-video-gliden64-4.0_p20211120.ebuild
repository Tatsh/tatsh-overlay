# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake flag-o-matic

DESCRIPTION="A new generation, open-source graphics plugin for N64 emulators."
HOMEPAGE="https://github.com/gonetz/GLideN64"
SHA="1956f78234f634553ccb8e9e8323cbd67da549d9"
SRC_URI="https://github.com/gonetz/GLideN64/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/opengl
	media-libs/freetype
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
	# This prepends it before the build system adds its own -std=gnu++17,
	# unfortunately after a -std=c++11 flag. gnu++17 will not work because that
	# flag is already included and it will get deduped. Kind of a hack.
	append-cxxflags -std=gnu++14
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
