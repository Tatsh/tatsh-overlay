# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="Nintendo Switch emulator."
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"
MY_PV="mainline-${PV/./-}"
CPP_HTTPLIB_SHA="6d963fbe8d415399d65e94db7910bbd22fe3741c"
CPP_JWT_SHA="10ef5735d842b31025f1257ae78899f50a40fb14"
_DYNARMIC_SHA="7da378033a7764f955516f75194856d87bbcd7a5"
NX_TZDB_VERSION="221202"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
SDL_SHA="cc016b0046d563287f0aa9f09b958b5e70d43696"
SIMPLEINI_SHA="382ddbb4b92c0b26aa1b32cefba2002119a5b1f2"
SIRIT_SHA="ab75463999f4f3291976b079d42d52ee91eebf3f"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/yuzu-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/MerryMage/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/releases/download/${NX_TZDB_VERSION}/${NX_TZDB_VERSION}.zip -> ${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip
	https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-sdl-${SDL_SHA:0:7}.tar.gz
	https://github.com/brofield/simpleini/archive/${SIMPLEINI_SHA}.tar.gz -> ${PN}-simpleini-${SIMPLEINI_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compatibility-reporting +cubeb +web-service +webengine"
REQUIRED_USE="compatibility-reporting? ( web-service )"

DEPEND=">=app-arch/zstd-1.5.0:=
	>=dev-libs/xbyak-6.03:=
	>=media-video/ffmpeg-4.3
	app-arch/lz4
	cubeb? ( media-libs/cubeb )
	web-service? ( dev-cpp/cpp-httplib )
	dev-cpp/cpp-httplib:=
	dev-libs/boost:=[context]
	>=dev-libs/libfmt-9.1.0:=
	dev-libs/libzip
	dev-libs/openssl:=
	dev-libs/vulkan-memory-allocator:=
	dev-util/glslang
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	media-libs/libsdl2
	media-libs/libva
	media-libs/opus
	net-libs/enet:=
	sys-libs/libunwind
	sys-libs/zlib
	virtual/libusb:=
	webengine? ( dev-qt/qtwebengine:5 )"
RDEPEND="${DEPEND}
	media-libs/vulkan-loader"
BDEPEND="app-arch/unzip
	dev-cpp/cpp-jwt
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	>=dev-util/vulkan-headers-1.3.275
	dev-util/spirv-headers"

S="${WORKDIR}/${PN}-mainline-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-system-libs.patch"
)

pkg_setup() {
	wget -t 1 --timeout=15 -O "${T}/compatibility_list.json" https://api.yuzu-emu.org/gamedb/ ||
		rm -f "${T}/compatibility_list.json"
}

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}/externals/"{dynarmic,mbedtls,simpleini,sirit,SDL,xbyak} || die
	mv "${WORKDIR}/dynarmic-${_DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/simpleini-${SIMPLEINI_SHA}" "${S}/externals/simpleini" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	mkdir -p "${S}_build/externals/nx_tzdb/nx_tzdb" || die
	cp "${DISTDIR}/${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip" \
		"${S}_build/externals/nx_tzdb/${NX_TZDB_VERSION}.zip" || die
	mv "${WORKDIR}/zoneinfo" "${S}_build/externals/nx_tzdb/nx_tzdb/" || die
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
	cmake_src_prepare
	mkdir -p "${BUILD_DIR}/dist/compatibility_list" || die
	if ! [ -f "${T}/compatibility_list.json" ]; then
		einfo 'Using fallback compatibility list'
		gunzip < "${FILESDIR}/${PN}-fallback-compat.json.gz" > "${T}/compatibility_list.json" || die
	fi
	mv -f "${T}/compatibility_list.json" \
		"${BUILD_DIR}/dist/compatibility_list/compatibility_list.json" || die
}

src_configure() {
	# This is so I do not have to keep patching the VkResult:: constants in the error handler
	# switch/case statement in vulkan_wrapper.cpp. Oddly enough this works despite -Werror=all
	# coming after.
	append-cxxflags -Wno-switch
	local mycmakeargs=(
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
		"-DENABLE_CUBEB=$(usex cubeb)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DYUZU_DOWNLOAD_TIME_ZONE_DATA=OFF
		"-DYUZU_ENABLE_COMPATIBILITY_REPORTING=$(usex compatibility-reporting)"
		-DYUZU_TESTS=OFF
		-DYUZU_USE_EXTERNAL_SDL2=ON
		-DYUZU_USE_EXTERNAL_VULKAN_HEADERS=OFF
		-DYUZU_USE_QT_MULTIMEDIA=ON
		"-DYUZU_USE_QT_WEB_ENGINE=$(usex webengine)"
		-DYUZU_USE_FASTER_LD=OFF
		-Wno-dev
	)
	cmake_src_configure
}
