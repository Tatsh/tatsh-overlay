# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="A Nintendo 3DS emulator."
HOMEPAGE="https://github.com/azahar-emu/azahar https://azahar-emu.org/"
COMPAT_LIST_SHA="955c560089186a86a90b67f0427f6dfdabc1f177"
DDS_KTX_SHA="c3ca8febc2457ab5c581604f3236a8a511fc2e45"
LODEPNG_SHA="0b1d9ccfc2093e5d6620cd9a11d03ee6ff6705f5"
SIRIT_SHA="37d49d2aa4c0a62f872720d6e5f2eaf90b2c95fa"
SIRIT_SPIRV_HEADERS_SHA="3f17b2af6784bfa2c5aa5dbb8e0e74a607dd8b3b"
SOUNDTOUCH_SHA="9ef8458d8561d9471dd20e9619e3be4cfe564796"
SUB_DYNARMIC_SHA="278405bd71999ed3f3c77c5f78344a06fef798b9"
XBYAK_SHA="0d67fd1530016b7c56f3cd74b3fca920f4c3e2b4"
BISCUIT_SHA="8bd0f7538b9ed7bedf90e789ffbd9eaeb484b28d"
CATCH_SHA="914aeecfe23b1e16af6ea675a4fb5dbd5a5b8d0a"
FMT_SHA="123913715afeb8a437e6388b4473fcc4753e1c9a"
MCL_SHA="7b08d83418f628b800dfac1c9a16c3f59036fbad"
OAKNUT_SHA="6b1d57ea7ed4882d32a91eeaa6557b0ecb4da152"
ROBIN_MAP_SHA="054ec5ad67440fcd65e0497e5a27ef31f53fcc7f"
ZYCORE_SHA="0b2432ced0884fd152b471d97ecf0258ff4d859f"
ZYDIS_SHA="bffbb610cfea643b98e87658b9058382f7522807"
SRC_URI="https://github.com/azahar-emu/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/lvandeve/lodepng/archive/${LODEPNG_SHA}.tar.gz -> ${PN}-lodepng-${LODEPNG_SHA:0:7}.tar.gz
	https://github.com/azahar-emu/dynarmic/archive/${SUB_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${SUB_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz -> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz
	https://codeberg.org/soundtouch/soundtouch/archive/${SOUNDTOUCH_SHA}.tar.gz -> ${PN}-soundtouch-${SOUNDTOUCH_SHA:0:7}.tar.gz
	https://github.com/septag/dds-ktx/archive/${DDS_KTX_SHA}.tar.gz -> ${PN}-dds-ktx-${DDS_KTX_SHA:0:7}.tar.gz
	https://github.com/azahar-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Headers/archive/${SIRIT_SPIRV_HEADERS_SHA}.tar.gz -> ${PN}-sirit-spirv-headers-${SIRIT_SPIRV_HEADERS_SHA:0:7}.tar.gz
	https://github.com/lioncash/biscuit/archive/${BISCUIT_SHA}.tar.gz -> ${PN}-dynarmic-biscuit-${BISCUIT_SHA:0:7}.tar.gz
	https://github.com/catchorg/Catch2/archive/${CATCH_SHA}.tar.gz -> ${PN}-dynarmic-catch-${CATCH_SHA:0:7}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_SHA}.tar.gz -> ${PN}-dynarmic-fmt-${FMT_SHA:0:7}.tar.gz
	https://github.com/azahar-emu/mcl/archive/${MCL_SHA}.tar.gz -> ${PN}-dynarmic-mcl-${MCL_SHA:0:7}.tar.gz
	https://github.com/merryhime/oaknut/archive/${OAKNUT_SHA}.tar.gz -> ${PN}-dynarmic-oaknut-${OAKNUT_SHA:0:7}.tar.gz
	https://github.com/Tessil/robin-map/archive/${ROBIN_MAP_SHA}.tar.gz -> ${PN}-dynarmic-robin-map-${ROBIN_MAP_SHA:0:7}.tar.gz
	https://github.com/zyantific/zycore-c/archive/${ZYCORE_SHA}.tar.gz -> ${PN}-dynarmic-zycore-${ZYCORE_SHA:0:7}.tar.gz
	https://github.com/zyantific/zydis/archive/${ZYDIS_SHA}.tar.gz -> ${PN}-dynarmic-zydis-${ZYDIS_SHA:0:7}.tar.gz
	https://github.com/azahar-emu/compatibility-list/archive/${COMPAT_LIST_SHA}.tar.gz -> ${PN}-compatibility-list-${COMPAT_LIST_SHA}.tar.gz"

LICENSE="ZLIB BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="openal +qt6 +scripting +web-service"

# System xbyak is still used by Dynarmic, but not Citra itself
DEPEND="app-arch/zstd
	web-service? ( dev-cpp/cpp-jwt )
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
	dev-util/glslang
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
	"${FILESDIR}/${PN}-0003-boost-fix.patch"
	"${FILESDIR}/${PN}-0004-boost-1.87.patch"
	"${FILESDIR}/${PN}-0005-ffmpeg.patch"
)

src_prepare() {
	rmdir "externals/lodepng/lodepng" \
		"externals/"{soundtouch,dynarmic,fmt,xbyak,dds-ktx,sirit} || die
	mv "${WORKDIR}/soundtouch" "externals/soundtouch" || die
	mv "${WORKDIR}/dds-ktx-${DDS_KTX_SHA}" "externals/dds-ktx" || die
	mv "${WORKDIR}/dynarmic-${SUB_DYNARMIC_SHA}" "externals/dynarmic" || die
	rmdir "externals/dynarmic/externals/"{biscuit,catch,fmt,mcl,oaknut,robin-map,xbyak,zycore,zydis} || die
	mv "${WORKDIR}/biscuit-${BISCUIT_SHA}" externals/dynarmic/externals/biscuit || die
	mv "${WORKDIR}/Catch2-${CATCH_SHA}" externals/dynarmic/externals/catch || die
	mv "${WORKDIR}/fmt-${FMT_SHA}" externals/dynarmic/externals/fmt || die
	mv "${WORKDIR}/mcl-${MCL_SHA}" externals/dynarmic/externals/mcl || die
	mv "${WORKDIR}/oaknut-${OAKNUT_SHA}" externals/dynarmic/externals/oaknut || die
	mv "${WORKDIR}/robin-map-${ROBIN_MAP_SHA}" externals/dynarmic/externals/robin-map || die
	cp -r "${WORKDIR}/xbyak-${XBYAK_SHA}" externals/dynarmic/externals/xbyak || die
	mv "${WORKDIR}/zycore-c-${ZYCORE_SHA}" externals/dynarmic/externals/zycore || die
	mv "${WORKDIR}/zydis-${ZYDIS_SHA}" externals/dynarmic/externals/zydis || die
	mv "${WORKDIR}/lodepng-${LODEPNG_SHA}" "externals/lodepng/lodepng" || die
	mv "${WORKDIR}/sirit-${SIRIT_SHA}" "externals/sirit" || die
	rmdir "externals/sirit/externals/SPIRV-Headers" || die
	mv "${WORKDIR}/SPIRV-Headers-${SIRIT_SPIRV_HEADERS_SHA}" "externals/sirit/externals/SPIRV-Headers"
	cp -r "${WORKDIR}/xbyak-${XBYAK_SHA}" "externals/xbyak" || die
	rmdir "dist/compatibility_list" || die
	mv "${WORKDIR}/compatibility-list-${COMPAT_LIST_SHA}" "dist/compatibility_list" || die
	# shellcheck disable=SC2016
	sed -e 's|${CMAKE_CURRENT_SOURCE_DIR}/xbyak/xbyak|/usr/include/xbyak|' \
		-i externals/dynarmic/externals/CMakeLists.txt || die
	sed -re 's/-W(all|error)//g' -i externals/dynarmic/CMakeLists.txt \
		externals/dynarmic/externals/catch/CMake/CatchMiscFunctions.cmake \
		externals/dynarmic/externals/catch/CMakeLists.txt \
		externals/dynarmic/externals/fmt/CMakeLists.txt \
		externals/dynarmic/externals/mcl/CMakeLists.txt \
		externals/dynarmic/externals/oaknut/CMakeLists.txt \
		externals/dynarmic/externals/robin-map/tests/CMakeLists.txt \
		externals/dynarmic/externals/zycore/CMakeLists.txt \
		externals/dynarmic/externals/zycore/cmake/zyan-functions.cmake \
		externals/sirit/CMakeLists.txt \
		src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	append-flags -fPIC
	local mycmakeargs=(
		"-DENABLE_OPENAL=$(usex openal)"
		"-DENABLE_QT=$(usex qt6)"
		"-DENABLE_SCRIPTING=$(usex scripting)"
		"-DENABLE_WEB_SERVICE=$(usex web-service)"
		-DBUILD_SHARED_LIBS=OFF
		-DCITRA_USE_PRECOMPILED_HEADERS=OFF
		-DCITRA_WARNINGS_AS_ERRORS=OFF
		-DDISABLE_SUBMODULE_CHECK=ON
		-DDYNARMIC_USE_BUNDLED_EXTERNALS=ON
		-DENABLE_LTO=OFF # Do not enable their way of doing this.
		-DENABLE_TESTS=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CATCH2=ON
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
		-DUSE_SYSTEM_QT=ON
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
