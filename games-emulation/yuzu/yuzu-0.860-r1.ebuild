# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/ https://github.com/yuzu-emu/yuzu-mainline"

MY_PV="mainline-${PV/./-}"
DYNARMIC_SHA="cce7e4ee5d7b07a4609c73c053fbf57dc8c78458"
HTTPLIB_SHA="9648f950f5a8a41d18833cf4a85f5821b1bcac54"
SDL_SHA="e2ade2bfc46d915cd306c63c830b81d800b2575f"
SIRIT_SHA="a39596358a3a5488c06554c0c15184a6af71e433"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/yhirose/cpp-httplib/archive/${HTTPLIB_SHA}.tar.gz -> ${PN}-httplib-${HTTPLIB_SHA:0:7}.tar.gz
	https://github.com/libsdl-org/SDL/archive/${SDL_SHA}.tar.gz -> ${PN}-sdl-${SDL_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compatibility-reporting +cubeb experimental +web-service"
REQUIRED_USE="compatibility-reporting? ( web-service )"

DEPEND="app-arch/lz4
	>=app-arch/zstd-1.5.0
	dev-libs/boost:=[context]
	cubeb? ( dev-libs/cubeb )
	experimental? ( dev-libs/openssl )
	dev-libs/inih
	>=dev-libs/libfmt-8.0.0
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtwebengine
	dev-qt/qtwidgets
	media-libs/opus
	>=media-video/ffmpeg-4.3
	<net-libs/mbedtls-3.1.0[cmac]
	sys-libs/libunwind
	sys-libs/zlib
	x11-libs/libva
	virtual/libusb:="
RDEPEND="${DEPEND}
	media-libs/vulkan-loader"
BDEPEND=">=dev-cpp/catch-2.13.7
	dev-cpp/nlohmann_json
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/spirv-headers"

S="${WORKDIR}/${PN}-mainline-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-6833-unbundle-libs.patch"
	"${FILESDIR}/${PN}-7610-unbundle-opus.patch"
	"${FILESDIR}/${PN}-7044-system-mbedtls.patch"
)

pkg_setup() {
	wget -O "${T}/compatibility_list.json" https://api.yuzu-emu.org/gamedb/ || die
}

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}/externals/"{soundtouch,dynarmic,sirit,cpp-httplib,SDL} || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/cpp-httplib-${HTTPLIB_SHA}" "${S}/externals/cpp-httplib" || die
	mv "${WORKDIR}/SDL-${SDL_SHA}" "${S}/externals/SDL" || die
	sed -e 's/find_package(Boost .*/find_package(Boost 1.71 COMPONENTS context REQUIRED)/' -i src/common/CMakeLists.txt || die
	sed -e '/enable_testing.*/d' -e 's/add_subdirectory(externals\/SPIRV-Headers.*/find_package(SPIRV-Headers REQUIRED)/' -i externals/sirit/CMakeLists.txt || die
	mkdir -p "${BUILD_DIR}/dist/compatibility_list" || die
	mv -f "${T}/compatibility_list.json" "${BUILD_DIR}/dist/compatibility_list/compatibility_list.json" || die
	if use experimental; then
		# Disable due to 7213 issue https://github.com/yuzu-emu/yuzu/pull/7213#issuecomment-1001306268
		sed -e '/-Werror=missing-declarations/d' -i src/CMakeLists.txt || die
		eapply "${FILESDIR}/${PN}-6769-create-shortcuts.patch"
		eapply "${FILESDIR}/${PN}-6858-disable-collecttoolinginfo.patch"
		eapply "${FILESDIR}/${PN}-7259-ioctrlfreeventbatch.patch"
		eapply "${FILESDIR}/${PN}-7621-setmemorypermission.patch"
		eapply "${FILESDIR}/${PN}-7622-vk-texture-cache-fix-invalidated-pointer-access.patch"
		for i in {1..4}; do
			eapply "${FILESDIR}/${PN}-7213-openssl-0${i}.patch"
		done
	fi
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
		-DUSE_DISCORD_PRESENCE=OFF
		-DYUZU_USE_EXTERNAL_SDL2=ON
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=$(usex compatibility-reporting)
		-DYUZU_USE_BUNDLED_BOOST=OFF
		-DYUZU_USE_BUNDLED_CUBEB=OFF
		-DYUZU_USE_BUNDLED_INIH=OFF
		-DYUZU_USE_BUNDLED_OPUS=oFF
		-DYUZU_USE_BUNDLED_XBYAK=OFF
		-DYUZU_USE_OPENSSL_CRYPTO=$(usex experimental)
		-DYUZU_USE_QT_WEB_ENGINE=ON
		-Wno-dev
	)
	cmake_src_configure
}
