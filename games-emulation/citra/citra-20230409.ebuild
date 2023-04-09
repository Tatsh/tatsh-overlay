# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://citra-emu.org/ https://github.com/citra-emu/citra"
SHA="8d19483b7e3837bc64a7190093f4cfab98e4d70d"
DYNARMIC_SHA="c08c5a9362bb224dc343c2f616c24df027dfdf13"
LODEPNG_SHA="18964554bc769255401942e0e6dfd09f2fab2093"
SOUNDTOUCH_SHA="060181eaf273180d3a7e87349895bd0cb6ccbf4a"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
SRC_URI="https://github.com/citra-emu/citra/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/citra-emu/ext-soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/citra-emu/dynarmic/archive/${DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${DYNARMIC_SHA:0:7}.tar.gz
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
	dev-libs/libfmt
	dev-libs/mp
	dev-libs/teakra
	>=dev-libs/xbyak-5.941
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtwidgets:5
	dev-util/nihstro
	media-libs/libsdl2
	media-video/ffmpeg
	net-libs/enet:=
	virtual/libusb:1"
RDEPEND="${DEPEND}"
BDEPEND="dev-cpp/catch:0"

PATCHES=(
	"${FILESDIR}/${PN}-0001-system-libraries.patch"
	"${FILESDIR}/${PN}-0002-inih-fix.patch"
	"${FILESDIR}/${PN}-0003-disable-tests.patch"
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
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_SDL2=ON
		-DUSE_SYSTEM_TEAKRA=ON
		-DUSE_SYSTEM_XBYAK=OFF
		-DUSE_SYSTEM_ZSTD=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -fR "${D}/usr/include" "${D}/usr/$(get_libdir)" || die
}
