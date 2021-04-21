# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/"
MY_PV="mainline-${PV/./-}"
DYNARMIC_SHA="b2a4da5e65985e6b0a20ac8ac37d14425a2a39d9"
MBEDTLS_SHA="eac2416b8fdb2cb9c867a538100bf95326bad75b"
SIRIT_SHA="eefca56afd49379bdebc97ded8b480839f930881"
SIRIT_SPIRV_HEADERS_SHA="2c512180ca03b5d4f56283efc85745775b45fdc4"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
SRC_URI="https://github.com/yuzu-emu/yuzu-mainline/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/yuzu-emu/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SIRIT_SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-sirit-spirv-headers-${SIRIT_SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz"

LICENSE="BSD GPL-2 GPL-2+ LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+compat-list +cubeb +web-service"

DEPEND="app-arch/lz4
	app-arch/zstd
	dev-libs/boost:=[context]
	cubeb? ( dev-libs/cubeb )
	dev-libs/inih
	dev-libs/libfmt
	dev-libs/libzip
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtwidgets
	media-libs/libsdl2
	media-libs/opus
	media-video/ffmpeg
	sys-libs/zlib
	virtual/libusb:="
RDEPEND="${DEPEND}
	app-arch/zstd
	media-libs/vulkan-loader"
BDEPEND="dev-cpp/catch
	dev-cpp/nlohmann_json
	dev-util/vulkan-headers"

S="${WORKDIR}/${PN}-mainline-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-Allow-use-of-system-Opus-and-inih.patch"
	"${FILESDIR}/${PN}-0003-fix-INIReader.h-includes.patch"
	"${FILESDIR}/${PN}-0004-minimalise-finding-Boost-components.patch"
	"${FILESDIR}/${PN}-0005-Support-newer-Vulkan-headers.patch"
	"${FILESDIR}/${PN}-0006-Allow-system-cubeb.patch"
	"${FILESDIR}/${PN}-0100-unbundle-xbyak.patch"
	"${FILESDIR}/${PN}-0101-mime-type.patch"
	"${FILESDIR}/${PN}-0102-inject-git-info.patch"
)

src_prepare() {
	rm .gitmodules || die
	rmdir "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
	mv "${WORKDIR}/SPIRV-Headers-${SIRIT_SPIRV_HEADERS_SHA}" "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
	rmdir "${S}/externals/"{soundtouch,dynarmic,sirit,mbedtls} || die
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	sed -e 's/find_package(Boost .*/find_package(Boost 1.71 COMPONENTS context REQUIRED)/' -i src/common/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_FULLNAME=""
		-DBUILD_FULLNAME="${MY_PV}"
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_COMPATIBILITY_LIST_DOWNLOAD=$(usex compat-list)
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DGIT_BRANCH="${PN}"
		-DGIT_DESC="${PV}"
		-DGIT_REV="${PV}"
		-DUSE_DISCORD_PRESENCE=OFF
		-DUSE_SYSTEM_CUBEB=$(usex cubeb)
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_OPUS=ON
		-DYUZU_ENABLE_COMPATIBILITY_REPORTING=ON
		-DYUZU_USE_QT_WEB_ENGINE=ON
	)
	cmake_src_configure
}
