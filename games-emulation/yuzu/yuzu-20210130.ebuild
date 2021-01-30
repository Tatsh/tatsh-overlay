# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake

DESCRIPTION="Nintendo Switch emulator"
HOMEPAGE="https://yuzu-emu.org/"
MY_SHA="650734cc3e4127d19579adaffa6122a49751851d"
DYNARMIC_SHA="3806284cbefc4115436dcdc687776a45ec313093"
MBEDTLS_SHA="a280e602f3a4ae001d3a83cbc3e6e04c99c22277"
SIRIT_SHA="eefca56afd49379bdebc97ded8b480839f930881"
SIRIT_SPIRV_HEADERS_SHA="2c512180ca03b5d4f56283efc85745775b45fdc4"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
XBYAK_SHA="c306b8e5786eeeb87b8925a8af5c3bf057ff5a90"
SRC_URI="https://github.com/yuzu-emu/yuzu/archive/${MY_SHA}.tar.gz -> ${PN}.tar.gz
	https://github.com/DarkLordZach/mbedtls/archive/${MBEDTLS_SHA}.tar.gz -> ${PN}-mbedtls-${MBEDTLS_SHA:0:7}.tar.gz
	https://github.com/MerryMage/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/ReinUsesLisp/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SIRIT_SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-sirit-spirv-headers-${SIRIT_SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/lz4
	app-arch/zstd
	dev-libs/boost
	dev-libs/cubeb
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
	virtual/libusb:="
RDEPEND="${DEPEND}"
BDEPEND="dev-util/vulkan-headers"

S="${WORKDIR}/${PN}-${MY_SHA}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-Allow-use-of-system-Opus-and-inih.patch"
	"${FILESDIR}/${PN}-0002-Fix-libzip-typo.patch"
	"${FILESDIR}/${PN}-0003-fix-INIReader.h-includes.patch"
	"${FILESDIR}/${PN}-0004-minimalise-finding-Boost-components.patch"
	"${FILESDIR}/${PN}-0005-Support-newer-Vulkan-headers.patch"
	"${FILESDIR}/${PN}-0006-Allow-system-cubeb.patch"
)

src_prepare() {
	rm .gitmodules
	rmdir "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
	mv "${WORKDIR}/SPIRV-Headers-${SIRIT_SPIRV_HEADERS_SHA}" "${WORKDIR}/sirit-${SIRIT_SHA}/externals/SPIRV-Headers" || die
	rmdir "${S}/externals/"{soundtouch,dynarmic,sirit,mbedtls,xbyak} || die
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/mbedtls-${MBEDTLS_SHA}" "${S}/externals/mbedtls" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	cmake_src_prepare
	{ pushd "${S}/externals/dynarmic" && eapply "${FILESDIR}/${PN}-0099-dynarmic-include-xbyak.patch" && popd; } || die
	# Force sirit and dynarmic to be static libs
	for i in sirit dynarmic; do
		sed -r -e "s/add_library\(${i}/add_library(${i} STATIC/" -i "${S}/externals/${i}/src/CMakeLists.txt" || die
	done
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CUBEB=ON
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_OPUS=ON
	)
	cmake_src_configure
}
