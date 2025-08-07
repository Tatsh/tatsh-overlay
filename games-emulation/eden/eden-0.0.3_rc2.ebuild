# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="Nintendo Switch emulator."
HOMEPAGE="https://eden-emu.dev/ https://git.eden-emu.dev/eden-emu/eden"
CPP_JWT_SHA="4a970bc302d671476122cbc6b43cc89fbf4a96ec"
FFMPEG_SHA="cc6fb1643d7e14c6f76a48e0cffad96394cb197c"
XBYAK_VERSION="7.05"
_DYNARMIC_ZYDIS_SHA="c2d2bab0255e53a7c3e9b615f4eb69449eb942df"
_DYNARMIC_UNORDERED_DENSE_SHA="e59d30b7b12e1d04cc2fc9c6219e35bda447c17e"
_DYNARMIC_ZYCORE_C_SHA="75a36c45ae1ad382b0f4e0ede0af84c11ee69928"
SRC_URI="https://git.eden-emu.dev/eden-emu/${PN}/archive/v${PV//_/-}.tar.gz -> ${P}.tar.gz
	https://github.com/herumi/xbyak/archive/refs/tags/v${XBYAK_VERSION}.tar.gz -> ${PN}-${XBYAK_VERSION}.tar.gz
	https://github.com/FFmpeg/FFmpeg/archive/${FFMPEG_SHA}.tar.gz -> ${PN}-ffmpeg-${FFMPEG_SHA:0:7}.tar.gz
	https://github.com/zyantific/zydis/archive/${_DYNARMIC_ZYDIS_SHA}.tar.gz -> ${PN}-zydis-${_DYNARMIC_ZYDIS_SHA:0:7}.tar.gz
	https://github.com/Lizzie841/unordered_dense/archive/${_DYNARMIC_UNORDERED_DENSE_SHA}.tar.gz -> ${PN}-unordered_dense-${_DYNARMIC_UNORDERED_DENSE_SHA:0:7}.tar.gz
	https://github.com/zyantific/zycore-c/archive/${_DYNARMIC_ZYCORE_C_SHA}.tar.gz -> ${PN}-zycore-c-${_DYNARMIC_ZYCORE_C_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
# KEYWORDS="~amd64 ~x86"
IUSE="+cubeb llvm-libunwind +web-service +webengine"

DEPEND=">=app-arch/zstd-1.5.0:=
	app-arch/lz4
	cubeb? ( media-libs/cubeb )
	web-service? ( dev-cpp/cpp-httplib )
	dev-libs/boost:=[context]
	>=dev-libs/libfmt-9.1.0:=
	dev-libs/libzip
	dev-libs/openssl:=
	dev-libs/vulkan-memory-allocator:=
	dev-util/vulkan-utility-libraries
	dev-util/glslang
	dev-qt/qtbase:6
	dev-qt/qtmultimedia:6
	media-libs/libsdl2
	media-libs/libva
	media-libs/opus
	net-libs/enet:=
	sys-libs/zlib
	virtual/libusb:=
	x11-libs/libX11
	x11-libs/libdrm
	x11-libs/libvdpau
	webengine? ( dev-qt/qtwebengine:6 )
	llvm-libunwind? ( llvm-runtimes/libunwind )
	!llvm-libunwind? ( sys-libs/libunwind:= )"
RDEPEND="${DEPEND}
	media-libs/vulkan-loader"
BDEPEND="app-arch/unzip
	dev-cpp/cpp-jwt
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	>=dev-util/vulkan-headers-1.3.275
	dev-util/spirv-headers
	app-text/dos2unix"

PATCHES=(
#	"${FILESDIR}/${PN}-0001-re-apply-patches.patch"
#	"${FILESDIR}/${PN}-0002-fix-call-to-add-externals.patch"
#	"${FILESDIR}/${PN}-0003-fix-undefined-var.patch"
#	"${FILESDIR}/${PN}-0004-boost-1.88.patch"
)

S="${WORKDIR}/${PN}"

src_prepare() {
	rm .gitmodules || die
	dos2unix dist/*.desktop || die
	rmdir "${S}/externals/xbyak" || die
	rmdir "${S}/externals/ffmpeg/ffmpeg" || die
	rmdir "${S}/externals/dynarmic/externals/"{unordered_dense,zycore-c,zydis} || die
	mv "${WORKDIR}/unordered_dense-${_DYNARMIC_UNORDERED_DENSE_SHA}" "${S}/externals/dynarmic/externals/unordered_dense" || die
	mv "${WORKDIR}/zycore-c-${_DYNARMIC_ZYCORE_C_SHA}" "${S}/externals/dynarmic/externals/zycore-c" || die
	mv "${WORKDIR}/zydis-${_DYNARMIC_ZYDIS_SHA}" "${S}/externals/dynarmic/externals/zydis" || die
	mv "${WORKDIR}/FFmpeg-${FFMPEG_SHA}" "${S}/externals/ffmpeg/ffmpeg" || die
	mv "${WORKDIR}/xbyak-${XBYAK_VERSION}" "${S}/externals/xbyak" || die
	sed -e 's/find_package(Boost .*/find_package(Boost 1.71 COMPONENTS context REQUIRED)/' \
		-i src/common/CMakeLists.txt || die
	sed -e '/enable_testing.*/d' \
		-e 's/add_subdirectory(externals\/SPIRV-Headers.*/find_package(SPIRV-Headers REQUIRED)/' \
		-i externals/sirit/CMakeLists.txt || die
	sed -e '/-Werror=missing-declarations/d' -i src/CMakeLists.txt || die
	sed -re 's/(find_package\(Vulkan ).*/\1)/' \
		-e 's/VulkanMemoryAllocator/VulkanMemoryAllocator REQUIRED/' -i CMakeLists.txt || die
	sed -re 's/set\(CAN_BUILD_NX_TZDB.*/set(CAN_BUILD_NX_TZDB false)/' \
		-i externals/nx_tzdb/CMakeLists.txt || die
	sed -re '/-Werror=.*/d' -i src/CMakeLists.txt || die
	sed -re 's/@GIT_BRANCH@/eden/' -e "s/@GIT_DESC@/${PV}/" -i src/common/scm_rev.cpp.in || die
	cmake_src_prepare
#	mkdir -p "${BUILD_DIR}/dist/compatibility_list" || die
#	einfo 'Using fallback compatibility list'
#	gunzip < "${FILESDIR}/${PN}-fallback-compat.json.gz" > "${T}/compatibility_list.json" || die
#	mv -f "${T}/compatibility_list.json" \
#		"${BUILD_DIR}/dist/compatibility_list/compatibility_list.json" || die
}

src_configure() {
	# This is so I do not have to keep patching the VkResult:: constants in the error handler
	# switch/case statement in vulkan_wrapper.cpp. Oddly enough this works despite -Werror=all
	# coming after.
	append-cxxflags -Wno-switch
	local mycmakeargs=(
		"-DENABLE_CUBEB=$(usex cubeb)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		"-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)"
		-DCMAKE_DISABLE_FIND_PACKAGE_xbyak=ON
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF  # FIXME
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
		-DENABLE_QT6=ON
		-DENABLE_QT_UPDATE_CHECKER=OFF
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DYUZU_CRASH_DUMPS=ON
		-DYUZU_DOWNLOAD_TIME_ZONE_DATA=OFF
		-DYUZU_ENABLE_PORTABLE=OFF
		-DYUZU_ROOM=ON
		-DYUZU_TESTS=OFF
		-DYUZU_USE_BUNDLED_FFMPEG=ON
		-DYUZU_USE_EXTERNAL_SDL2=OFF
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=OFF
		-DYUZU_USE_EXTERNAL_VULKAN_SPIRV_TOOLS=OFF
		-DYUZU_USE_EXTERNAL_VULKAN_UTILITY_LIBRARIES=OFF
		-DYUZU_USE_FASTER_LD=OFF
		-DYUZU_USE_PRECOMPILED_HEADERS=OFF
		-DYUZU_USE_QT_MULTIMEDIA=ON
		-Wno-dev
	)
	cmake_src_configure
}
