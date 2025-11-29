# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LIBRETRO_REPO_NAME="libretro/dolphin"
LIBRETRO_COMMIT_SHA="bfac84ab609696a96a24261fd3bb5f12e90c2409"
LIBRETRO_CORE_NAME="dolphin"
inherit libretro-core cmake

DESCRIPTION="A Gamecube/Wii emulator core for libretro"
HOMEPAGE="https://github.com/libretro/dolphin"
IMPLOT_SHA="3da8bd34299965d3b0ab124df743fe3e076fa222"
TINYGLTF_SHA="c5641f2c22d117da7971504591a8f6a41ece488b"
WATCHER_SHA="b03bdcfc11549df595b77239cefe2643943a3e2f"
SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}-${LIBRETRO_COMMIT_SHA:0:7}.tar.gz
	https://github.com/syoyo/tinygltf/archive/${TINYGLTF_SHA}.tar.gz -> tinygltf-${TINYGLTF_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> implot-${IMPLOT_SHA:0:7}.tar.gz
	https://github.com/e-dant/watcher/archive/${WATCHER_SHA}.tar.gz -> watcher-${WATCHER_SHA:0:7}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+opengl vulkan +X"

DEPEND="
	<dev-libs/libfmt-10
	dev-libs/lzo
	media-libs/libpng
	media-libs/mesa
	net-libs/mbedtls
	net-misc/curl
	sys-libs/readline
	virtual/zlib
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		dev-qt/qtconcurrent
	)
	opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader )
	virtual/libusb
"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

src_prepare() {
	rmdir Externals/tinygltf/tinygltf Externals/implot/implot Externals/watcher/watcher || die
	mv "${WORKDIR}/tinygltf-${TINYGLTF_SHA}" Externals/tinygltf/tinygltf || die
	mv "${WORKDIR}/implot-${IMPLOT_SHA}" Externals/implot/implot || die
	mv "${WORKDIR}/watcher-${WATCHER_SHA}" Externals/watcher/watcher || die
	sed -re 's|dolphin_find_optional_system_library\(glslang Externals/glslang 15\.0\)|dolphin_find_optional_system_library(glslang Externals/glslang)|' -i CMakeLists.txt || die
	libretro-core_src_prepare
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCCACHE_BIN=CCACHE_BIN-NOTFOUND
		-DENABLE_LLVM=OFF
		-DBUILD_SHARED_LIBS=OFF
		-DLIBRETRO=ON
		-DLIBRETRO_STATIC=1
		-DENABLE_QT=0
		-DUSE_SYSTEM_GLSLANG=ON
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX=/usr
		-DENABLE_X11="$(usex X)"
	)
	cmake_src_configure
}

src_install() {
	LIBRETRO_LIB_DIR="${EROOT}/usr/$(get_libdir)/libretro"
	insinto "${LIBRETRO_LIB_DIR}"
	doins "${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"
}
