# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE=Release
inherit cmake desktop multiprocessing xdg

DESCRIPTION="Experimental Symbian OS emulator"
HOMEPAGE="https://eka2l1.com https://github.com/EKA2L1/EKA2L1"
SHA="cd7041f58192899d7f2c3c29444487b0d6fefe0b"
CAPSTONE_SHA="52c66920fc7bfa15fd9626dfd9f646c698aaa99b"
_DYNARMIC_SHA="855e885288fc21a616ed07ee4437f34abe7c3922"
FFMPEG_SHA="569633bfe198554354afefa59859a871ee28e551"
LIBFAT_SHA="ea55c7a718780057e7fe0224d7423c4279fd3df7"
LIBTESS2_SHA="fc52516467dfa124bdd967c15c7cf9faf02a34ca"
LUNASVG_SHA="017bda5e3428d69bc40a8d44195b97c4f26d7bbe"
MICROPROFILE_SHA="b910f4df7f670affec65c1a4dacbf6018c9e0f1b"
MINIBAE_SHA="4a63a5d1a5ba50b71445b6a4b1efdd139872541b"
RECTANGLEBINPACK_SHA="83e7e1132d93777e3732dfaae26b0f3703be2036"
SDL_GAMECONTROLLERDB_SHA="a113e7fa25cc13ca6131b20a23568dc42c8a7dab"
THREAD_POOL_SHA="6790920f61ab3e928ddaea835ab6a803d467f41d"
TINYSOUNDFONT_SHA="e86d986ed6ccb93b4ee41d2de656c49c721b18db"
UPSCALE_SHADERS_SHA="49dd304cb97e7c0871256f2bafba7b6fd41511cb"
UVW_SHA="cf0f8c6fd4084900646b7c83b4682a12be76f10e"
SRC_URI="https://github.com/EKA2L1/EKA2L1/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/capstone-engine/capstone/archive/${CAPSTONE_SHA}.tar.gz -> ${PN}-capstone-${CAPSTONE_SHA:0:7}.tar.gz
	https://github.com/EKA2L1/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-${_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/EKA2L1/ffmpeg/archive/${FFMPEG_SHA}.tar.gz -> ${PN}-ffmpeg-${FFMPEG_SHA:0:7}.tar.gz
	https://github.com/Vita3K/libfat16/archive/${LIBFAT_SHA}.tar.gz -> ${PN}-libfat16-${LIBFAT_SHA:0:7}.tar.gz
	https://github.com/memononen/libtess2/archive/${LIBTESS2_SHA}.tar.gz -> ${PN}-libtess2-${LIBTESS2_SHA:0:7}.tar.gz
	https://github.com/EKA2L1/lunasvg/archive/${LUNASVG_SHA}.tar.gz -> ${PN}-lunasvg-${LUNASVG_SHA:0:7}.tar.gz
	https://github.com/jonasmr/microprofile/archive/${MICROPROFILE_SHA}.tar.gz -> ${PN}-microprofile-${MICROPROFILE_SHA:0:7}.tar.gz
	https://github.com/EKA2L1/miniBAE/archive/${MINIBAE_SHA}.tar.gz -> ${PN}-miniBAE-${MINIBAE_SHA:0:7}.tar.gz
	https://github.com/juj/RectangleBinPack/archive/${RECTANGLEBINPACK_SHA}.tar.gz -> ${PN}-RectangleBinPack-${RECTANGLEBINPACK_SHA:0:7}.tar.gz
	https://github.com/gabomdq/SDL_GameControllerDB/archive/${SDL_GAMECONTROLLERDB_SHA}.tar.gz -> ${PN}-SDL_GameControllerDB-${SDL_GAMECONTROLLERDB_SHA:0:7}.tar.gz
	https://github.com/bshoshany/thread-pool/archive/${THREAD_POOL_SHA}.tar.gz -> ${PN}-thread-pool-${THREAD_POOL_SHA:0:7}.tar.gz
	https://github.com/schellingb/TinySoundFont/archive/${TINYSOUNDFONT_SHA}.tar.gz -> ${PN}-TinySoundFont-${TINYSOUNDFONT_SHA:0:7}.tar.gz
	https://github.com/EKA2L1/upscale-shaders/archive/${UPSCALE_SHADERS_SHA}.tar.gz -> ${PN}-upscale-shaders-${UPSCALE_SHADERS_SHA:0:7}.tar.gz
	https://github.com/skypjack/uvw/archive/${UVW_SHA}.tar.gz -> ${PN}-uvw-${UVW_SHA:0:7}.tar.gz"
S="${WORKDIR}/EKA2L1-${SHA}"

# EKA2L1 GPL-3+, capstone BSD, dynarmic 0BSD, FFmpeg (with opencore-amr) LGPL-3+,
# libtess2 SGI-B-2.0, miniBAE BSD, RectangleBinPack public-domain,
# SDL_GameControllerDB ZLIB, upscale shaders GPL-2+ MIT, the rest MIT.
LICENSE="0BSD BSD GPL-2+ GPL-3+ LGPL-3+ MIT SGI-B-2.0 ZLIB public-domain"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/libarchive:=
	dev-cpp/yaml-cpp:=
	dev-db/sqlite:3
	dev-lang/luajit:2
	dev-libs/boost
	dev-libs/libfmt:=
	dev-libs/libuv:=
	dev-libs/pugixml
	dev-libs/re2:=
	dev-libs/spdlog:=
	dev-libs/stb
	dev-libs/wayland
	dev-libs/xxhash
	dev-qt/qtbase:6[gui,network,opengl,widgets]
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	media-libs/cubeb
	media-libs/freetype
	media-libs/glm
	media-libs/libglvnd
	media-libs/libsdl2
	media-libs/opencore-amr
	net-libs/mbedtls:3
	net-libs/miniupnpc:=
	virtual/zlib:=
	x11-libs/libX11"
RDEPEND="${DEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig
	amd64? ( dev-lang/nasm )"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

src_prepare() {
	local ext="${S}/src/external" dir
	for dir in capstone dynarmic ffmpeg libtess2 lunasvg microprofile miniBAE RectangleBinPack \
		SDL_GameControllerDB thread-pool TinySoundFont uvw; do
		rmdir "${ext}/${dir}" || die
		mv "${WORKDIR}/${dir}-"* "${ext}/${dir}" || die
	done
	rmdir "${ext}/libfat" || die
	mv "${WORKDIR}/libfat16-${LIBFAT_SHA}" "${ext}/libfat" || die
	rmdir "${S}/src/emu/drivers/resources/upscale" || die
	mv "${WORKDIR}/upscale-shaders-${UPSCALE_SHADERS_SHA}" "${S}/src/emu/drivers/resources/upscale" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# The emulator's internal libraries depend on each other cyclically.
		-DBUILD_SHARED_LIBS=OFF
		-DCCACHE_PROGRAM=CCACHE_PROGRAM-NOTFOUND
		-DEKA2L1_BUILD_TESTS=OFF
		-DEKA2L1_BUILD_TOOLS=OFF
		-DEKA2L1_ENABLE_QT_CAMERA=ON
		-DEKA2L1_FFMPEG_CACHE_DIR="${BUILD_DIR}/ffmpeg-cache"
		-DEKA2L1_FFMPEG_JOBS="$(makeopts_jobs)"
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	# The Qt frontend copies these next to itself, then seeds ~/.local/share/EKA2L1 from that
	# directory on every start.
	local dest
	dest="/usr/$(get_libdir)/${PN}"
	exeinto "${dest}"
	doexe "${BUILD_DIR}/bin/eka2l1_qt"
	insinto "${dest}"
	doins -r "${BUILD_DIR}"/bin/{compat,patch,resources,scripts}
	dosym -r "${dest}/eka2l1_qt" /usr/bin/eka2l1_qt
	domenu src/emu/qt/eka2l1.desktop
	doicon -s 128 src/emu/qt/assets/duck_tank.png
	einstalldocs
}
