# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://citra-emu.org/ https://github.com/citra-emu/citra"
SHA="e13735b6245af0dab111af3a1c16aefa6ee4db67"
DDS_KTX_SHA="42dd8aa6ded90b1ec06091522774feff51e83fc5"
LODEPNG_SHA="18964554bc769255401942e0e6dfd09f2fab2093"
SIRIT_SHA="4ab79a8c023aa63caaa93848b09b9fe8b183b1a9"
SIRIT_SPIRV_HEADERS_SHA="c214f6f2d1a7253bb0e9f195c2dc5b0659dc99ef"
SOUNDTOUCH_SHA="dd2252e9af3f2d6b749378173a4ae89551e06faf"
SUB_DYNARMIC_SHA="c08c5a9362bb224dc343c2f616c24df027dfdf13"
XBYAK_SHA="a1ac3750f9a639b5a6c6d6c7da4259b8d6790989"
SRC_URI="https://github.com/citra-emu/citra/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/citra-emu/dynarmic/archive/${SUB_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${SUB_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://codeberg.org/soundtouch/soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/septag/dds-ktx/archive/${DDS_KTX_SHA}.tar.gz -> ${PN}-dds-ktx-${DDS_KTX_SHA:0:7}.tar.gz
	https://github.com/yuzu-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-yuzu-emu-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SIRIT_SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-yuzu-emu-sirit-spirv-headers-${SIRIT_SPIRV_HEADERS_SHA:0:7}.tar.gz"

LICENSE="ZLIB BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openal +qt6 scripting web-service"

# System xbyak is still used by Dynarmic, but not Citra itself
DEPEND="app-arch/zstd
	dev-cpp/robin-map
	dev-libs/boost:0[nls]
	dev-libs/crypto++:=
	dev-libs/openssl
	media-libs/cubeb
	dev-libs/inih
	dev-libs/libfmt
	dev-libs/mp
	dev-libs/teakra
	dev-libs/vulkan-memory-allocator
	>=dev-libs/xbyak-5.941
	qt6? ( dev-qt/qtbase:6 dev-qt/qtmultimedia:6 )
	dev-util/nihstro
	media-libs/faad2
	media-libs/libsdl2
	media-video/ffmpeg
	net-libs/enet:=
	virtual/libusb:1
	openal? ( media-libs/openal )"
RDEPEND="${DEPEND} media-libs/fdk-aac"
BDEPEND="dev-cpp/catch:0 media-libs/fdk-aac"

PATCHES=(
	"${FILESDIR}/${PN}-0001-system-libraries.patch"
	"${FILESDIR}/${PN}-0002-inih-fix.patch"
)

S="${WORKDIR}/${PN}-${SHA}"

pkg_setup() {
	wget -O "${T}/compatibility_list.json" https://api.citra-emu.org/gamedb/ || die
}

src_prepare() {
	rmdir "${S}/externals/lodepng/lodepng" \
		"${S}/externals/"{soundtouch,dynarmic,fmt,xbyak,dds-ktx,sirit} || die
	mv "${WORKDIR}/soundtouch" "${S}/externals/soundtouch" || die
	mv "${WORKDIR}/dds-ktx-${DDS_KTX_SHA}" "${S}/externals/dds-ktx" || die
	mv "${WORKDIR}/dynarmic-${SUB_DYNARMIC_SHA}" "${S}/externals/dynarmic" || die
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "${S}/externals/lodepng/lodepng" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "${S}/externals/sirit" || die
	rmdir "${S}/externals/sirit/externals/SPIRV-Headers" || die
	mv "${WORKDIR}/SPIRV-Headers-${SIRIT_SPIRV_HEADERS_SHA}" "${S}/externals/sirit/externals/SPIRV-Headers"
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/externals/xbyak" || die
	mkdir -p "${WORKDIR}/${P}_build/dist/compatibility_list" || die
	mv -f "${T}/compatibility_list.json" "${WORKDIR}/${P}_build/dist/compatibility_list/compatibility_list.json" || die
	# shellcheck disable=SC2016
	sed -e 's|${CMAKE_CURRENT_SOURCE_DIR}/xbyak/xbyak|/usr/include/xbyak|' \
		-i externals/dynarmic/externals/CMakeLists.txt || die
	sed -re 's/-W(all|error)//g' -i externals/dynarmic/CMakeLists.txt \
		externals/dynarmic/externals/catch/CMake/CatchMiscFunctions.cmake \
		externals/dynarmic/externals/catch/CMakeLists.txt \
		externals/dynarmic/externals/fmt/CMakeLists.txt \
		externals/dynarmic/externals/mcl/CMakeLists.txt \
		externals/dynarmic/externals/robin-map/tests/CMakeLists.txt \
		externals/dynarmic/externals/zycore/CMakeLists.txt \
		externals/dynarmic/externals/zycore/cmake/zyan-functions.cmake \
		externals/sirit/CMakeLists.txt \
		src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DENABLE_OPENAL=$(usex openal)"
		"-DENABLE_QT=$(usex qt6)"
		"-DENABLE_SCRIPTING=$(usex scripting)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		-DBUILD_SHARED_LIBS=OFF
		-DCITRA_WARNINGS_AS_ERRORS=OFF
		-DDISABLE_SUBMODULE_CHECK=ON
		-DENABLE_QT_UPDATER=OFF
		-DENABLE_TESTS=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CRYPTOPP=ON
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_ENET=ON
		-DUSE_SYSTEM_FAAD2=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_GLSLANG=ON
		-DUSE_SYSTEM_INIH=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_OPENAL=ON
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_SDL2=ON
		-DUSE_SYSTEM_TEAKRA=ON
		-DUSE_SYSTEM_XBYAK=OFF
		-DUSE_SYSTEM_ZSTD=ON
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	local libdir
	libdir=$(get_libdir)
	rm -fR "${D}/usr/include" "${D}/usr/${libdir:?}" || die
}
