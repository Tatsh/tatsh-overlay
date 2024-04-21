# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg

DESCRIPTION="Continuation fork of Yuzu."
HOMEPAGE="https://git.suyu.dev/suyu/suyu https://suyu.dev/"
CPP_HTTPLIB_SHA="a609330e4c6374f741d3b369269f7848255e1954"
CPP_JWT_SHA="10ef5735d842b31025f1257ae78899f50a40fb14"
_DYNARMIC_SHA="ba8192d89078af51ae6f97c9352e3683612cdff1"
NX_TZDB_SHA="97929690234f2b4add36b33657fe3fe09bd57dfd"
NX_TZDB_VERSION="221202"
MBEDTLS_SHA="8c88150ca139e06aa2aae8349df8292a88148ea1"
SDL_SHA="cc016b0046d563287f0aa9f09b958b5e70d43696"
SIMPLEINI_SHA="382ddbb4b92c0b26aa1b32cefba2002119a5b1f2"
SIRIT_SHA="ab75463999f4f3291976b079d42d52ee91eebf3f"
XBYAK_SHA="9c0f5d3ecb06d2c93c2b59becb9b3b763213e74e"
SRC_URI="https://git.${PN}.dev/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://git.${PN}.dev/${PN}/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://git.${PN}.dev/${PN}/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${_DYNARMIC_SHA:0:7}.tar.gz
	https://git.${PN}.dev/${PN}/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/archive/${NX_TZDB_SHA}.tar.gz -> ${PN}-nx_tzdb-${NX_TZDB_SHA:0:7}.tar.gz
	https://github.com/lat9nq/tzdb_to_nx/releases/download/${NX_TZDB_VERSION}/${NX_TZDB_VERSION}.zip -> ${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip
	https://github.com/yhirose/cpp-httplib/archive/${CPP_HTTPLIB_SHA}.tar.gz -> ${PN}-cpp-httplib-${CPP_HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-sdl-${SDL_SHA:0:7}.tar.gz
	https://github.com/brofield/simpleini/archive/${SIMPLEINI_SHA}.tar.gz -> ${PN}-simpleini-${SIMPLEINI_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+compatibility-reporting +cubeb llvm-libunwind +web-service +webengine"
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
	webengine? ( dev-qt/qtwebengine:6 )
	llvm-libunwind? ( sys-libs/llvm-libunwind )
	!llvm-libunwind? ( sys-libs/libunwind:= )"
RDEPEND="${DEPEND}
	media-libs/vulkan-loader"
BDEPEND="app-arch/unzip
	dev-cpp/cpp-jwt
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	>=dev-util/vulkan-headers-1.3.275
	dev-util/spirv-headers"

S="${WORKDIR}/${PN}"

PATCHES=( "${FILESDIR}/${PN}-0001-system-libs.patch" )

pkg_setup() {
	wget -t 1 --timeout=15 -O "${T}/compatibility_list.json" https://api.yuzu-emu.org/gamedb/ ||
		rm -f "${T}/compatibility_list.json"
}

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}/externals/"{dynarmic,mbedtls,simpleini,sirit,SDL,xbyak,nx_tzdb/tzdb_to_nx} || die
	mv "${WORKDIR}/dynarmic" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/sirit" "${S}/externals/sirit" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	mv "${WORKDIR}/mbedtls" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/simpleini-${SIMPLEINI_SHA}" "${S}/externals/simpleini" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	mkdir -p "${S}_build/externals/nx_tzdb/nx_tzdb" || die
	cp "${DISTDIR}/${PN}-nx_tzdb-${NX_TZDB_VERSION}.zip" \
		"${S}_build/externals/nx_tzdb/${NX_TZDB_VERSION}.zip" || die
	mv "${WORKDIR}/zoneinfo" "${S}_build/externals/nx_tzdb/nx_tzdb/" || die
	mv "${WORKDIR}/tzdb_to_nx-${NX_TZDB_SHA}" "${S}/externals/nx_tzdb/tzdb_to_nx" || die
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
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF  # FIXME
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
		-DENABLE_QT6=ON
		"-DENABLE_CUBEB=$(usex cubeb)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DSUYU_DOWNLOAD_TIME_ZONE_DATA=OFF
		"-DSUYU_ENABLE_COMPATIBILITY_REPORTING=$(usex compatibility-reporting)"
		-DSUYU_TESTS=OFF
		-DSUYU_USE_EXTERNAL_SDL2=ON
		-DSUYU_USE_EXTERNAL_VULKAN_HEADERS=OFF
		-DSUYU_USE_EXTERNAL_VULKAN_UTILITY_LIBRARIES=OFF
		-DSUYU_USE_QT_MULTIMEDIA=ON
		"-DSUYU_USE_QT_WEB_ENGINE=$(usex webengine)"
		-DSUYU_USE_FASTER_LD=OFF
		-Wno-dev
	)
	cmake_src_configure
}
