# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://citra-emu.org/ https://github.com/citra-emu/citra"
SHA="357025dfdf2b08204b0a3ae38330dc5fe3f05103"
DYNARMIC_SHA="9f88f234a180a5e8d5620b4803c971fb6dc2d9f2"
FMT_SHA="cc09f1a6798c085c325569ef466bcdcffdc266d4"
LODEPNG_SHA="31d9704fdcca0b68fb9656d4764fa0fb60e460c2"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
XBYAK_SHA="c306b8e5786eeeb87b8925a8af5c3bf057ff5a90"
SRC_URI="https://github.com/citra-emu/citra/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/citra-emu/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_SHA}.tar.gz -> ${PN}-fmt-${FMT_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz"

LICENSE="ZLIB BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="web-service"

# System xbyak is still used by Dynarmic, but not Citra itself
DEPEND="app-arch/zstd
	dev-libs/boost:0
	dev-libs/crypto++:=
	media-libs/cubeb
	dev-libs/inih
	dev-libs/mp
	dev-libs/teakra
	>=dev-libs/xbyak-5.941
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qtmultimedia
	dev-qt/qtwidgets
	dev-util/nihstro
	media-libs/libsdl2
	media-video/ffmpeg
	net-libs/enet:=
	virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND="<dev-cpp/catch-3.0.0"

PATCHES=(
	"${FILESDIR}/${PN}-inih.patch"
	"${FILESDIR}/${PN}-system-libs.patch"
)

S="${WORKDIR}/${PN}-${SHA}"

pkg_setup() {
	wget -O "${T}/compatibility_list.json" https://api.citra-emu.org/gamedb/ || die
}

src_prepare() {
	rmdir "${S}/externals/lodepng/lodepng" \
		"${S}/externals/"{soundtouch,dynarmic,fmt,xbyak} || die
	mv "${WORKDIR}/ext-soundtouch-${SOUNDTOUCH_SHA}" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	mv "${WORKDIR}/dynarmic-${DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/fmt-${FMT_SHA}" "${S}/externals/fmt" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	mkdir -p "${WORKDIR}/${P}_build/dist/compatibility_list" || die
	mv -f "${T}/compatibility_list.json" "${WORKDIR}/${P}_build/dist/compatibility_list/compatibility_list.json" || die
	sed -e 's|${CMAKE_CURRENT_SOURCE_DIR}/xbyak/xbyak|/usr/include/xbyak|' \
		-i externals/dynarmic/externals/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DDISABLE_SUBMODULE_CHECK=ON
		-DENABLE_FFMPEG_AUDIO_DECODER=ON
		-DENABLE_FFMPEG_VIDEO_DUMPER=ON
		-DENABLE_WEB_SERVICE=$(usex web-service)
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CRYPTOPP=ON
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_ENET=ON
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_TEAKRA=ON
		-DUSE_SYSTEM_XBYAK=OFF
		-DUSE_SYSTEM_ZSTD=ON
	)
	cmake_src_configure
}
