# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV="mainline-${PV/./-}"
DYNARMIC_SHA="57af72a567454b93c757e087b4510a24b81911b1"
HTTPLIB_SHA="305a7abcb9b4e9e349843c6d563212e6c1bbbf21"
SDL_SHA="e2ade2bfc46d915cd306c63c830b81d800b2575f"
SIRIT_SHA="aa292d56650bc28f2b2d75973fab2e61d0136f9c"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${HTTPLIB_SHA}.tar.gz -> ${PN}-httplib-${HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-sdl-${SDL_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compatibility-reporting +cubeb +web-service"
REQUIRED_USE="compatibility-reporting? ( web-service )"

DEPEND="app-arch/lz4
	>=app-arch/zstd-1.5.0
	dev-libs/boost:=[context]
	cubeb? ( media-libs/cubeb )
	dev-libs/openssl
	dev-libs/inih
	>=dev-libs/libfmt-8.0.0
	dev-libs/libzip
	>=dev-libs/xbyak-6.03
	dev-cpp/robin-map
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtwebengine
	dev-qt/qtwidgets
	media-libs/opus
	>=media-video/ffmpeg-4.3
	sys-libs/libunwind
	sys-libs/zlib
	x11-libs/libva
	virtual/libusb:="
RDEPEND="${DEPEND}
	media-libs/vulkan-loader"
BDEPEND="<dev-cpp/catch-3.0.0
	dev-cpp/nlohmann_json
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/spirv-headers"

S="${WORKDIR}/${PN}-mainline-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-6769-create-shortcuts.patch"
	"${FILESDIR}/${PN}-6858-disable-collecttoolinginfo.patch"
	"${FILESDIR}/${PN}-7259-ioctrlfreeventbatch.patch"
	"${FILESDIR}/${PN}-7213-openssl.patch"
	"${FILESDIR}/${PN}-6833-unbundle-libs.patch"
	"${FILESDIR}/${PN}-revert-new-vkresult.patch"
	"${FILESDIR}/${PN}-system-robin-map.patch"
)

pkg_setup() {
	wget -O "${T}/compatibility_list.json" https://api.yuzu-emu.org/gamedb/ || die
}

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}/externals/"{dynarmic,sirit,cpp-httplib,SDL} || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/cpp-httplib-${HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	sed -e 's/find_package(Boost .*/find_package(Boost 1.71 COMPONENTS context REQUIRED)/' -i src/common/CMakeLists.txt || die
	sed -e '/enable_testing.*/d' -e 's/add_subdirectory(externals\/SPIRV-Headers.*/find_package(SPIRV-Headers REQUIRED)/' -i externals/sirit/CMakeLists.txt || die
	mkdir -p "${BUILD_DIR}/dist/compatibility_list" || die
	mv -f "${T}/compatibility_list.json" "${BUILD_DIR}/dist/compatibility_list/compatibility_list.json" || die
	sed -e '/-Werror=missing-declarations/d' -i src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DCONAN_REQUIRED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_DISCORD_PRESENCE=OFF
		-DYUZU_USE_EXTERNAL_SDL2=ON
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=$(usex compatibility-reporting)
		-DYUZU_USE_BUNDLED_CUBEB=OFF
		-DYUZU_USE_BUNDLED_HTTPLIB=ON
		-DYUZU_USE_BUNDLED_INIH=OFF
		-DYUZU_USE_BUNDLED_OPUS=OFF
		-DYUZU_USE_BUNDLED_XBYAK=OFF
		-DYUZU_USE_OPENSSL_CRYPTO=ON
		-DYUZU_USE_QT_WEB_ENGINE=ON
		-Wno-dev
	)
	cmake_src_configure
}
