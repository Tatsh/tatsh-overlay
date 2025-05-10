# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="Nintendo Switch emulator."
HOMEPAGE="https://sudachi.emuplace.app/"
BREAKPAD_SHA="bf1260ddb8d405e95cd5c4507ddaca45d10dd842"
CPP_JWT_SHA="4a970bc302d671476122cbc6b43cc89fbf4a96ec"
_DYNARMIC_SHA="efa2ebefe1f502fc886cbbcebabed2506121eb24"
FFMPEG_SHA="cc6fb1643d7e14c6f76a48e0cffad96394cb197c"
NX_TZDB_VERSION="221202"
MBEDTLS_SHA="86ed7bfaa80079a97c763a651d0b2cd8d9d59100"
SDL_SHA="87d6beb89539b03ea08255adb410a809ca5b41e9"
SIMPLEINI_SHA="f7862c3dd7ad35becc2741f268e3402e89a37666"
SIRIT_SHA="795ef4d8318c7d344da99c076dd60e5580d3d5ac"
XBYAK_VERSION="7.05"
SRC_URI="https://github.com/emuplace/sudachi.emuplace.app/releases/download/v${PV}/latest.zip -> ${P}.zip
	https://github.com/sudachi-emu/breakpad/archive/${BREAKPAD_SHA}.tar.gz -> ${P}-breakpad-${BREAKPAD_SHA:0:7}.tar.gz
	https://github.com/sudachi-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/sudachi-emu/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/sudachi-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/releases/download/${NX_TZDB_VERSION}/${NX_TZDB_VERSION}.zip -> ${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-sdl-${SDL_SHA:0:7}.tar.gz
	https://github.com/brofield/simpleini/archive/${SIMPLEINI_SHA}.tar.gz -> ${PN}-simpleini-${SIMPLEINI_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/refs/tags/v${XBYAK_VERSION}.tar.gz -> ${PN}-${XBYAK_VERSION}.tar.gz
	https://github.com/FFmpeg/FFmpeg/archive/${FFMPEG_SHA}.tar.gz -> ${PN}-ffmpeg-${FFMPEG_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	"${FILESDIR}/${PN}-0001-re-apply-patches.patch"
	"${FILESDIR}/${PN}-0002-fix-call-to-add-externals.patch"
	"${FILESDIR}/${PN}-0003-fix-undefined-var.patch"
	"${FILESDIR}/${PN}-0004-boost-1.88.patch"
)

src_unpack() {
	default
	rm .gitmodules || die
	dos2unix dist/*.desktop || die
	mkdir "${P}" || die
	mv "${WORKDIR}"/{dist,externals,CMakeLists.txt,src,CMakeModules,vcpkg.json} "${S}" || die
	mv "${WORKDIR}"/{LICENSES,LICENSE.md,hooks,README.md} "${S}" || die
}

src_prepare() {
	rmdir "${S}/externals/"{SDL3,breakpad,dynarmic,mbedtls,simpleini,sirit,xbyak} || die
	rmdir "${S}/externals/ffmpeg/ffmpeg" || die
	mv "${WORKDIR}/breakpad-${BREAKPAD_SHA}" "externals/breakpad" || die
	mv "${WORKDIR}/dynarmic-${_DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL3" || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/FFmpeg-${FFMPEG_SHA}" "${S}/externals/ffmpeg/ffmpeg" || die
	mv "${WORKDIR}/simpleini-${SIMPLEINI_SHA}" "${S}/externals/simpleini" || die
	mv "${WORKDIR}/xbyak-${XBYAK_VERSION}" "${S}/externals/xbyak" || die
	mkdir -v -p "${WORKDIR}/${P}_build/externals/nx_tzdb/nx_tzdb" || die
	cp "${DISTDIR}/${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip" \
		"${WORKDIR}/${P}_build/externals/nx_tzdb/${NX_TZDB_VERSION}.zip" || die
	mv "${WORKDIR}/zoneinfo" "${WORKDIR}/${P}_build/externals/nx_tzdb/nx_tzdb/" || die
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
	sed -re 's/@GIT_BRANCH@/sudachi/' -e "s/@GIT_DESC@/${PV}/" -i src/common/scm_rev.cpp.in || die
	cmake_src_prepare
	mkdir -p "${BUILD_DIR}/dist/compatibility_list" || die
	einfo 'Using fallback compatibility list'
	gunzip < "${FILESDIR}/${PN}-fallback-compat.json.gz" > "${T}/compatibility_list.json" || die
	mv -f "${T}/compatibility_list.json" \
		"${BUILD_DIR}/dist/compatibility_list/compatibility_list.json" || die
}

src_configure() {
	# This is so I do not have to keep patching the VkResult:: constants in the error handler
	# switch/case statement in vulkan_wrapper.cpp. Oddly enough this works despite -Werror=all
	# coming after.
	append-cxxflags -Wno-switch
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_DISABLE_FIND_PACKAGE_xbyak=ON
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF  # FIXME
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
		-DENABLE_QT6=ON
		"-DENABLE_CUBEB=$(usex cubeb)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DSUDACHI_CRASH_DUMPS=ON
		-DSUDACHI_DOWNLOAD_TIME_ZONE_DATA=OFF
		-DSUDACHI_ENABLE_PORTABLE=OFF
		-DSUDACHI_ROOM=ON
		-DSUDACHI_TESTS=OFF
		-DSUDACHI_USE_BUNDLED_FFMPEG=ON
		-DSUDACHI_USE_EXTERNAL_VULKAN_HEADERS=OFF
		-DSUDACHI_USE_EXTERNAL_VULKAN_UTILITY_LIBRARIES=OFF
		-DSUDACHI_USE_PRECOMPILED_HEADERS=OFF
		-DSUDACHI_USE_QT_MULTIMEDIA=ON
		"-DSUDACHI_USE_QT_WEB_ENGINE=$(usex webengine)"
		-DSUDACHI_USE_FASTER_LD=OFF
		-Wno-dev
	)
	cmake_src_configure
}
