# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="PS3 emulator and debugger."
HOMEPAGE="https://rpcs3.net/ https://github.com/RPCS3/rpcs3"
ASMJIT_SHA="416f7356967c1f66784dc1580fe157f9406d8bff"
FFMPEG_SHA="ec6367d3ba9d0d57b9d22d4b87da8144acaf428f"
FUSION_SHA="066d4a63b2c714b20b0a8073a01fda7c5c6763f6"
GLSLANG_SHA="fc9889c889561c5882e83819dcaffef5ed45529b"
HIDAPI_SHA="f42423643ec9011c98cccc0bb790722bbbd3f30b"
ITTAPI_VERSION="3.18.12"
SOUNDTOUCH_SHA="3982730833b6daefe77dcfb32b5c282851640c17"
VULKAN_MEMORY_ALLOCATOR_SHA="1d8f600fd424278486eade7ed3e877c99f0846b1"
YAML_CPP_SHA="456c68f452da09d8ca84b375faa2b1397713eaba"
SRC_URI="https://github.com/RPCS3/rpcs3/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/RPCS3/ffmpeg-core/archive/${FFMPEG_SHA}.tar.gz -> ${PN}-ffmpeg-${FFMPEG_SHA:0:7}.tar.gz
	https://github.com/asmjit/asmjit/archive/${ASMJIT_SHA}.tar.gz -> ${PN}-asmjit-${ASMJIT_SHA:0:7}.tar.gz
	https://github.com/RPCS3/hidapi/archive/${HIDAPI_SHA}.tar.gz -> ${PN}-hidapi-${HIDAPI_SHA:0:7}.tar.gz
	https://github.com/RPCS3/yaml-cpp/archive/${YAML_CPP_SHA}.tar.gz -> ${PN}-yaml-cpp-${YAML_CPP_SHA:0:7}.tar.gz
	https://github.com/intel/ittapi/archive/refs/tags/v${ITTAPI_VERSION}.tar.gz -> ${PN}-ittapi-${ITTAPI_VERSION}.tar.gz
	https://github.com/RPCS3/soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SHA}.tar.gz -> glslang-${GLSLANG_SHA:0:7}.tar.gz
	https://github.com/xioTechnologies/Fusion/archive/${FUSION_SHA}.tar.gz -> fusion-${FUSION_SHA:0:7}.tar.gz
	https://github.com/Megamouse/VulkanMemoryAllocator/archive/${VULKAN_MEMORY_ALLOCATOR_SHA}.tar.gz -> megamouse-vulkan-memory-allocator-${VULKAN_MEMORY_ALLOCATOR_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="faudio joystick +llvm system-ffmpeg vulkan wayland"
REQUIRED_USE="wayland? ( vulkan )"

DEPEND="app-arch/zstd
	>=dev-libs/flatbuffers-2.0.6
	>=dev-libs/pugixml-1.15
	>=dev-libs/wolfssl-4.7.0[writedup]
	media-libs/cubeb
	dev-libs/xxhash
	dev-util/spirv-tools
	dev-qt/qtbase:6[opengl]
	dev-qt/qtdeclarative:6[opengl]
	dev-qt/qtmultimedia:6
	dev-qt/qtnetworkauth:6
	dev-qt/qtsvg:6
	llvm-core/llvm
	media-libs/glew:0
	media-libs/libglvnd[X]
	media-libs/libpng:*
	media-libs/openal
	media-libs/opencv:=
	media-libs/rtmidi
	media-video/ffmpeg
	net-libs/miniupnpc
	net-misc/curl
	sys-libs/ncurses
	sys-libs/zlib
	media-libs/libjpeg-turbo
	virtual/libusb:1
	virtual/udev
	x11-libs/libX11
	faudio? ( app-emulation/faudio )
	joystick? ( dev-libs/libevdev )
	vulkan? ( media-libs/vulkan-loader )
	wayland? ( dev-libs/wayland )"
RDEPEND="${DEPEND} dev-debug/gdb"
BDEPEND=">=sys-devel/gcc-9
	dev-util/spirv-headers
	dev-libs/stb"

PATCHES=(
	"${FILESDIR}/${PN}-0001-versioning.patch"
	"${FILESDIR}/${PN}-0002-add-use_wayland.patch"
	"${FILESDIR}/${PN}-0003-allow-use-of-system-spirv-an.patch"
	"${FILESDIR}/${PN}-0005-support-for-system-miniupnpc.patch"
	"${FILESDIR}/${PN}-0006-remove-extra.patch"
	"${FILESDIR}/${PN}-0007-allow-system-rtmidi.patch"
	"${FILESDIR}/${PN}-0008-add-missing-headers.patch"
	"${FILESDIR}/${PN}-0009-allow-use-of-system-zstd.patch"
	"${FILESDIR}/${PN}-0010-fix-openal-header-include.patch"
)

src_prepare() {
	rmdir "${S}/3rdparty/ffmpeg" || die
	mv "${WORKDIR}/ffmpeg-core-${FFMPEG_SHA}" "${S}/3rdparty/ffmpeg" || die
	rmdir "${S}/3rdparty/hidapi/hidapi" || die
	mv "${WORKDIR}/hidapi-${HIDAPI_SHA}" "${S}/3rdparty/hidapi/hidapi" || die
	rmdir "${S}/3rdparty/yaml-cpp/yaml-cpp" || die
	mv "${WORKDIR}/yaml-cpp-${YAML_CPP_SHA}" "${S}/3rdparty/yaml-cpp/yaml-cpp" || die
	rmdir "${S}/3rdparty/asmjit/asmjit" || die
	mv "${WORKDIR}/asmjit-${ASMJIT_SHA}" "${S}/3rdparty/asmjit/asmjit" || die
	rmdir "${S}/3rdparty/glslang/glslang" || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" "${S}/3rdparty/glslang/glslang" || die
	rmdir "${S}/3rdparty/fusion/fusion" || die
	mv "${WORKDIR}/Fusion-${FUSION_SHA}" "${S}/3rdparty/fusion/fusion" || die
	rmdir "${S}/3rdparty/GPUOpen/VulkanMemoryAllocator" || die
	mv "${WORKDIR}/VulkanMemoryAllocator-${VULKAN_MEMORY_ALLOCATOR_SHA}" "${S}/3rdparty/GPUOpen/VulkanMemoryAllocator" || die
	{ echo "#define RPCS3_GIT_VERSION \"0000-v${PV}\""
		echo '#define RPCS3_GIT_BRANCH "master"'
		echo '#define RPCS3_GIT_FULL_BRANCH "RPCS3/rpcs3/master"'
		echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1'; } > rpcs3/git-version.h
	sed -e '/find_program(CCACHE_FOUND/d' -i CMakeLists.txt || die
	sed -re '/\s+add_compile_options\(-Werror=missing-noreturn\).*/d' \
		-e '/\s+add_compile_options\(-Werror=old-style-cast\).*/d' \
		-i buildfiles/cmake/ConfigureCompiler.cmake || die
	mv "${WORKDIR}/ittapi-${ITTAPI_VERSION}" "${WORKDIR}/ittapi" || die
	rmdir "${S}/3rdparty/SoundTouch/soundtouch" || die
	mv "${WORKDIR}/soundtouch-${SOUNDTOUCH_SHA}" "${S}/3rdparty/SoundTouch/soundtouch" || die
	cmake_src_prepare
}

src_configure() {
	append-cflags -DNDEBUG
	append-cxxflags -DNDEBUG -I/usr/include/stb
	filter-lto
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_TESTING=OFF
		-DUSE_DISCORD_RPC=OFF
		"-DUSE_FAUDIO=$(usex faudio)"
		"-DUSE_SYSTEM_FAUDIO=$(usex faudio)"
		"-DUSE_LIBEVDEV=$(usex joystick)"
		-DUSE_NATIVE_INSTRUCTIONS=OFF
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_CURL=ON
		"-DUSE_SYSTEM_FFMPEG=$(usex system-ffmpeg)"
		-DUSE_SYSTEM_FLATBUFFERS=ON
		-DUSE_SYSTEM_GLSLANG=OFF
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_MINIUPNP=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_RTMIDI=ON
		-DUSE_SYSTEM_WOLFSSL=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_SYSTEM_ZSTD=ON
		"-DUSE_VULKAN=$(usex vulkan)"
		"-DUSE_WAYLAND=$(usex wayland)"
		"-DWITH_LLVM=$(usex llvm)"
		-Wno-dev
	)
	cmake_src_configure
}
