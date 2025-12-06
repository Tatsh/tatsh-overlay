# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
LIBRETRO_REPO_NAME="libretro/dolphin"
LIBRETRO_COMMIT_SHA="df2b1a754bba4f0595d3ed07ccd0711019e014b8"
LIBRETRO_CORE_NAME="dolphin"
inherit libretro-core cmake

DESCRIPTION="A Gamecube/Wii emulator core for libretro"
HOMEPAGE="https://github.com/libretro/dolphin"
IMPLOT_SHA="3da8bd34299965d3b0ab124df743fe3e076fa222"
TINYGLTF_SHA="c5641f2c22d117da7971504591a8f6a41ece488b"
VULKAN_HEADERS_SHA="39f924b810e561fd86b2558b6711ca68d4363f68"
VULKANMEMORYALLOCATOR_SHA="3bab6924988e5f19bf36586a496156cf72f70d9f"
WATCHER_SHA="b03bdcfc11549df595b77239cefe2643943a3e2f"
CPP_IPC_SHA="a0c7725a1441d18bc768d748a93e512a0fa7ab52"
CPP_OPTPARSE_SHA="2265d647232249a53a03b411099863ceca35f0d3"
IMGUI_SHA="45acd5e0e82f4c954432533ae9985ff0e1aad6d5"
SFML_SHA="016bea9491ccafc3529019fe1d403885a8b3a6ae"
SRC_URI="https://github.com/${LIBRETRO_REPO_NAME}/archive/${LIBRETRO_COMMIT_SHA}.tar.gz -> ${P}-${LIBRETRO_COMMIT_SHA:0:7}.tar.gz
	https://github.com/syoyo/tinygltf/archive/${TINYGLTF_SHA}.tar.gz -> tinygltf-${TINYGLTF_SHA:0:7}.tar.gz
	https://github.com/epezent/implot/archive/${IMPLOT_SHA}.tar.gz -> implot-${IMPLOT_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKAN_HEADERS_SHA}.tar.gz -> Vulkan-Headers-${VULKAN_HEADERS_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${VULKANMEMORYALLOCATOR_SHA}.tar.gz -> VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA:0:7}.tar.gz
	https://github.com/e-dant/watcher/archive/${WATCHER_SHA}.tar.gz -> watcher-${WATCHER_SHA:0:7}.tar.gz
	https://github.com/mutouyun/cpp-ipc/archive/${CPP_IPC_SHA}.tar.gz -> cpp-ipc-${CPP_IPC_SHA:0:7}.tar.gz
	https://github.com/weisslj/cpp-optparse/archive/${CPP_OPTPARSE_SHA}.tar.gz -> cpp-optparse-${CPP_OPTPARSE_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/SFML/SFML/archive/${SFML_SHA}.tar.gz -> SFML-${SFML_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+opengl vulkan +X"

DEPEND="
	>=sys-libs/zlib-ng-1.3.1:=
	>=sys-libs/minizip-ng-4.0.4:=
	dev-libs/hidapi
	>=dev-libs/libfmt-10.1
	dev-libs/lzo:2
	dev-libs/pugixml
	media-libs/libspng
	>=net-libs/enet-1.3.18:1.3=
	media-libs/mesa
	net-libs/mbedtls
	net-misc/curl
	sys-libs/readline
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrandr
		dev-qt/qtconcurrent
	)
	opengl? (
		virtual/opengl
		>=media-libs/libsfml-3.0:=
	)
	vulkan? ( media-libs/vulkan-loader )
	virtual/libusb
"
RDEPEND="${DEPEND}
	games-emulation/libretro-info"

src_prepare() {
	mv -T "${WORKDIR}/tinygltf-${TINYGLTF_SHA}" Externals/tinygltf/tinygltf || die
	mv -T "${WORKDIR}/implot-${IMPLOT_SHA}" Externals/implot/implot || die
	mv -T "${WORKDIR}/watcher-${WATCHER_SHA}" Externals/watcher/watcher || die
	mv -T "${WORKDIR}/cpp-ipc-${CPP_IPC_SHA}" Externals/cpp-ipc/cpp-ipc || die
	mv -T "${WORKDIR}/cpp-optparse-${CPP_OPTPARSE_SHA}" Externals/cpp-optparse/cpp-optparse || die
	mv -T "${WORKDIR}/imgui-${IMGUI_SHA}" Externals/imgui/imgui || die
	mv -T "${WORKDIR}/Vulkan-Headers-${VULKAN_HEADERS_SHA}" Externals/Vulkan-Headers || die
	mv -T "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_SHA}" Externals/VulkanMemoryAllocator || die
	if ! use opengl;
	then
		mv -T "${WORKDIR}/SFML-${SFML_SHA}" Externals/SFML/SFML || die
	fi
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
	LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}/${LIBRETRO_CORE_NAME}_libretro.so"
	libretro-core_src_install
}
