# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="PS3 emulator and debugger."
HOMEPAGE="https://rpcs3.net/ https://github.com/RPCS3/rpcs3"
ASMJIT_SHA="fc2a5d82f7434d7d03161275a764c051f970f41c"
FLATBUFFERS_SHA="615616cb5549a34bdf288c04bc1b94bd7a65c396"
HIDAPI_SHA="6cf133697c4413dc9ae0fefefeba5f33587dff76"
ITTAPI_VERSION="3.18.12"
LLVM_SHA="509d31ad89676522f7121b3bb8688f7d29b7ee60"
SOUNDTOUCH_SHA="83cfba67b6af80bb9bfafc0b324718c4841f2991"
YAML_CPP_SHA="0b67821f307e8c6bf0eba9b6d3250e3cf1441450"
SRC_URI="https://github.com/RPCS3/rpcs3/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/RPCS3/llvm-mirror/archive/${LLVM_SHA}.tar.gz -> ${PN}-llvm-${LLVM_SHA:0:7}.tar.gz
	https://github.com/asmjit/asmjit/archive/${ASMJIT_SHA}.tar.gz -> ${PN}-asmjit-${ASMJIT_SHA:0:7}.tar.gz
	https://github.com/RPCS3/hidapi/archive/${HIDAPI_SHA}.tar.gz -> ${PN}-hidapi-${HIDAPI_SHA:0:7}.tar.gz
	https://github.com/RPCS3/yaml-cpp/archive/${YAML_CPP_SHA}.tar.gz -> ${PN}-yaml-cpp-${YAML_CPP_SHA:0:7}.tar.gz
	https://github.com/intel/ittapi/archive/refs/tags/v${ITTAPI_VERSION}.tar.gz -> ${PN}-ittapi-${ITTAPI_VERSION}.tar.gz
	https://github.com/RPCS3/soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/google/flatbuffers/archive/${FLATBUFFERS_SHA}.tar.gz -> ${PN}-${FLATBUFFERS_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="faudio joystick +llvm vulkan wayland"
REQUIRED_USE="wayland? ( vulkan )"

DEPEND="dev-libs/pugixml
	>=dev-libs/wolfssl-4.7.0
	media-libs/cubeb
	dev-libs/xxhash
	dev-util/spirv-tools
	dev-qt/qtconcurrent
	dev-qt/qtcore:5
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtmultimedia
	dev-qt/qtnetwork:5
	dev-qt/qtsvg
	dev-qt/qtwidgets:5
	media-libs/glew:0
	media-libs/libglvnd
	media-libs/libpng:*
	media-libs/openal
	media-video/ffmpeg
	net-misc/curl
	sys-libs/ncurses
	sys-libs/zlib
	virtual/jpeg
	virtual/libusb:1
	virtual/opengl
	virtual/udev
	x11-libs/libX11
	faudio? ( app-emulation/faudio )
	joystick? ( dev-libs/libevdev )
	vulkan? (
		media-libs/vulkan-loader
		dev-util/glslang )
	wayland? ( dev-libs/wayland )"
RDEPEND="${DEPEND} sys-devel/gdb"
BDEPEND=">=sys-devel/gcc-9
	dev-util/spirv-headers"

PATCHES=(
	"${FILESDIR}/${PN}-0003-add-missing-include-fix-branch-names.patch"
	"${FILESDIR}/${PN}-0004-add-use_wayland.patch"
	"${FILESDIR}/${PN}-0006-vk.patch"
	"${FILESDIR}/${PN}-0007-allow-use-of-system-spirv-and-glslang.patch"
	"${FILESDIR}/${PN}-0008-system-cubeb.patch"
	"${FILESDIR}/${PN}-0009-ittapi-remove-git-co.patch"
)

src_prepare() {
	rmdir "${S}/llvm" || die
	mv "${WORKDIR}/llvm-mirror-${LLVM_SHA}" "${S}/llvm" || die
	rmdir "${S}/3rdparty/hidapi/hidapi" || die
	mv "${WORKDIR}/hidapi-${HIDAPI_SHA}" "${S}/3rdparty/hidapi/hidapi" || die
	rmdir "${S}/3rdparty/yaml-cpp/yaml-cpp" || die
	mv "${WORKDIR}/yaml-cpp-${YAML_CPP_SHA}" "${S}/3rdparty/yaml-cpp/yaml-cpp" || die
	rmdir "${S}/3rdparty/asmjit/asmjit" || die
	mv "${WORKDIR}/asmjit-${ASMJIT_SHA}" "${S}/3rdparty/asmjit/asmjit" || die
	echo "#define RPCS3_GIT_VERSION \"0000-v${PV}\"" > rpcs3/git-version.h
	echo '#define RPCS3_GIT_BRANCH "master"' >> rpcs3/git-version.h
	echo '#define RPCS3_GIT_FULL_BRANCH "RPCS3/rpcs3/master"' >> rpcs3/git-version.h
	echo '#define RPCS3_GIT_VERSION_NO_UPDATE 1' >> rpcs3/git-version.h
	sed -re 's/MATCHES "\^\(DEBUG\|RELEASE\|RELWITHDEBINFO\|MINSIZEREL\)\$/MATCHES "^(DEBUG|RELEASE|RELWITHDEBINFO|MINSIZEREL|GENTOO)/' \
		-i "${S}/llvm/CMakeLists.txt" || die
	sed -e '/find_program(CCACHE_FOUND/d' -i CMakeLists.txt || die
	sed -e 's|FAudio.h|FAudio/FAudio.h|' -i rpcs3/Emu/Audio/FAudio/FAudioBackend.h || die
	sed -re '/\s+add_compile_options\(-Werror=missing-noreturn\).*/d' \
		-e '/\s+add_compile_options\(-Werror=old-style-cast\).*/d' \
		-i buildfiles/cmake/ConfigureCompiler.cmake || die
	mv "${WORKDIR}/ittapi-${ITTAPI_VERSION}" "${WORKDIR}/ittapi"
	rmdir "${S}/3rdparty/SoundTouch/soundtouch" || die
	mv "${WORKDIR}/soundtouch-${SOUNDTOUCH_SHA}" "${S}/3rdparty/SoundTouch/soundtouch" || die
	rmdir "${S}/3rdparty/flatbuffers" || die
	mv "${WORKDIR}/flatbuffers-${FLATBUFFERS_SHA}" "${S}/3rdparty/flatbuffers" || die
	cmake_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_LLVM_SUBMODULE=ON
		"-DITTAPI_SOURCE_DIR=${WORKDIR}"
		-DUSE_PRECOMPILED_HEADERS=OFF
		-DUSE_DISCORD_RPC=OFF
		-DUSE_FAUDIO=$(usex faudio)
		-DUSE_SYSTEM_FAUDIO=$(usex faudio)
		-DUSE_LIBEVDEV=$(usex joystick)
		-DUSE_NATIVE_INSTRUCTIONS=OFF
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_CURL=ON
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_SYSTEM_FLATBUFFERS=OFF
		-DUSE_SYSTEM_GLSLANG=ON
		-DUSE_SYSTEM_LIBPNG=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_SPIRV_HEADERS_TOOLS=ON
		-DUSE_SYSTEM_WOLFSSL=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_ZLIB=ON
		-DUSE_VULKAN=$(usex vulkan)
		-DUSE_WAYLAND=$(usex wayland)
		-DWITH_LLVM=$(usex llvm)
		-Wno-dev
	)
	cmake_src_configure
}
