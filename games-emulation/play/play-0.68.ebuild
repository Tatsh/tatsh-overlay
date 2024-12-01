# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake flag-o-matic xdg

DESCRIPTION="PlayStation 2 emulator."
HOMEPAGE="http://purei.org/ https://github.com/jpd002/Play-"
MY_PV="${PV:0:4}"
CODEGEN_SHA="86c75c540c91e4672f15bd000f0a7a644f6afb1d"
DEPS_SHA="7d8bfd36fa609355e4087f7d661fc512bf77754c"
GHC_FILESYSTEM="2a8b380f8d4e77b389c42a194ab9c70d8e3a0f1e"
FRAMEWORK_SHA="715f56a4ba1b3f5d1d8d5918f8417adfb542a51b"
LIBCHDR_SHA="fec8ab94212cc65d9d9a62cb3da924f5830c04b0"
NUANCEUR_SHA="d5280b700d9da9ab9a61cdf0da29a87ffb6898f6"
ZSTD_SHA="1e09cffd9b15b39379810a39ffae182b4a7e7b78"
XXHASH_SHA="2de0fd6d9b3fd8bbb35ebd52152ecd11fc1ebbfc"
SRC_URI="https://github.com/jpd002/Play-/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/jpd002/Play--CodeGen/archive/${CODEGEN_SHA}.tar.gz -> ${PN}-codegen-${CODEGEN_SHA:0:7}.tar.gz
	https://github.com/jpd002/Play-Dependencies/archive/${DEPS_SHA}.tar.gz -> ${PN}-deps-${DEPS_SHA:0:7}.tar.gz
	https://github.com/jpd002/Play--Framework/archive/${FRAMEWORK_SHA}.tar.gz -> ${PN}-framework-${FRAMEWORK_SHA:0:7}.tar.gz
	https://github.com/jpd002/Nuanceur/archive/${NUANCEUR_SHA}.tar.gz -> ${PN}-nuanceur-${NUANCEUR_SHA:0:7}.tar.gz
	https://github.com/gulrak/filesystem/archive/${GHC_FILESYSTEM}.tar.gz -> ${PN}-filesystem-${GHC_FILESYSTEM:0:7}.tar.gz
	https://github.com/jpd002/libchdr/archive/${LIBCHDR_SHA}.tar.gz -> ${PN}-libchdr-${LIBCHDR_SHA:0:7}.tar.gz
	https://github.com/facebook/zstd/archive/${ZSTD_SHA}.tar.gz -> ${PN}-zstd-${ZSTD_SHA:0:7}.tar.gz
	https://github.com/Cyan4973/xxHash/archive/${XXHASH_SHA}.tar.gz -> ${PN}-xxhash-${XXHASH_SHA:0:7}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE="libretro vulkan"

DEPEND="app-arch/bzip2
	dev-db/sqlite
	dev-libs/icu
	dev-libs/libevdev
	dev-libs/openssl
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtx11extras
	media-libs/libglvnd
	media-libs/glu
	media-libs/openal
	net-misc/curl
	sys-libs/zlib
	vulkan? ( media-libs/vulkan-loader )"
RDEPEND="${DEPEND}"
BDEPEND="dev-cpp/nlohmann_json"

UPPER_PN="${PN^^}"
MY_PN="${UPPER_PN:0:1}${PN:1}-"
S="${WORKDIR}/${MY_PN}-${MY_PV}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-source-system-deps.patch"
	"${FILESDIR}/${PN}-framework-system-deps.patch"
)

src_prepare() {
	rmdir deps/{CodeGen,Dependencies,Framework,Nuanceur} || die
	mv "${WORKDIR}/${MY_PN}-CodeGen-${CODEGEN_SHA}" deps/CodeGen || die
	mv "${WORKDIR}/${MY_PN}Dependencies-${DEPS_SHA}" deps/Dependencies || die
	rmdir deps/Dependencies/{ghc_filesystem,zstd} || die
	mv "${WORKDIR}/filesystem-${GHC_FILESYSTEM}" deps/Dependencies/ghc_filesystem || die
	mv "${WORKDIR}/${MY_PN}-Framework-${FRAMEWORK_SHA}" deps/Framework || die
	mv "${WORKDIR}/Nuanceur-${NUANCEUR_SHA}" deps/Nuanceur || die
	mv "${WORKDIR}/xxHash-${XXHASH_SHA}" deps/Dependencies/xxHash || die
	mv "${WORKDIR}/zstd-${ZSTD_SHA}" deps/Dependencies/zstd || die
	rmdir deps/libchdr || die
	mv "${WORKDIR}/libchdr-${LIBCHDR_SHA}" deps/libchdr || die
	sed -e '/^set(PROJECT_Version/d' -i CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	# -DENABLE_AMAZON_S3=$(usex s3) currently broken, must be left ON
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		"-DBUILD_LIBRETRO_CORE=$(usex libretro)"
		"-DUSE_GSH_VULKAN=$(usex vulkan)"
		"-DPROJECT_Version=${PV}"
		-Wno-dev
	)
	# https://github.com/jpd002/Play-/issues/911
	append-cppflags -DNDEBUG
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use libretro; then
		insinto "/usr/$(get_libdir)/libretro"
		doins "${BUILD_DIR}/Source/ui_libretro/play_libretro.so"
	fi
}
