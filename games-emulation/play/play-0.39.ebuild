# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake xdg-utils

DESCRIPTION="PlayStation 2 emulator."
HOMEPAGE="http://purei.org/ https://github.com/jpd002/Play-"
MY_PV="${PV:0:4}"
BOOST_CMAKE_SHA="e97843ed8d7d069a278e6f2adf33a9f91638c73f"
CODEGEN_SHA="10068b1fd39efa88fbfb2fe14e820eae552fb2a1"
DEPS_SHA="e3e6669ecd40598b4e4adc1bc9297c6967f4c929"
FILESYSTEM_SHA="3605e869150032ffdd9eae3db93e12f8711a0c82"
FRAMEWORK_SHA="65baebea9ca9e7ce0631e71c8ede33f4e3d25a15"
NUANCEUR_SHA="29b04d3be3f25230fbb7511d6cbfdbe661149d33"
SRC_URI="https://github.com/jpd002/Play-/archive/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/jpd002/boost-cmake/archive/${BOOST_CMAKE_SHA}.tar.gz -> ${PN}-boost-cmake-${BOOST_CMAKE_SHA:0:7}.tar.gz
	https://github.com/jpd002/Play--CodeGen/archive/${CODEGEN_SHA}.tar.gz -> ${PN}-codegen-${CODEGEN_SHA:0:7}.tar.gz
	https://github.com/jpd002/Play-Dependencies/archive/${DEPS_SHA}.tar.gz -> ${PN}-deps-${DEPS_SHA:0:7}.tar.gz
	https://github.com/jpd002/Play--Framework/archive/${FRAMEWORK_SHA}.tar.gz -> ${PN}-framework-${FRAMEWORK_SHA:0:7}.tar.gz
	https://github.com/jpd002/Nuanceur/archive/${NUANCEUR_SHA}.tar.gz -> ${PN}-nuanceur-${NUANCEUR_SHA:0:7}.tar.gz
	https://github.com/gulrak/filesystem/archive/${FILESYSTEM_SHA}.tar.gz -> ${PN}-filesystem-${FILESYSTEM_SHA:0:7}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="libretro vulkan"
REQUIRED_USE="arm64? ( !vulkan )"

DEPEND="app-arch/bzip2
	dev-db/sqlite
	dev-libs/icu
	dev-libs/libevdev
	dev-libs/openssl
	dev-qt/qtgui
	dev-qt/qtwidgets
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

PATCHES=( "${FILESDIR}/${PN}-system-deps.patch" )

src_prepare() {
	rmdir deps/{CodeGen,Dependencies,Framework,Nuanceur} || die
	mv "${WORKDIR}/${MY_PN}-CodeGen-${CODEGEN_SHA}" deps/CodeGen || die
	mv "${WORKDIR}/${MY_PN}Dependencies-${DEPS_SHA}" deps/Dependencies || die
	rmdir deps/Dependencies/{boost-cmake,ghc_filesystem} || die
	mv "${WORKDIR}/boost-cmake-${BOOST_CMAKE_SHA}" deps/Dependencies/boost-cmake || die
	mv "${WORKDIR}/filesystem-${FILESYSTEM_SHA}" deps/Dependencies/ghc_filesystem || die
	mv "${WORKDIR}/${MY_PN}-Framework-${FRAMEWORK_SHA}" deps/Framework || die
	mv "${WORKDIR}/Nuanceur-${NUANCEUR_SHA}" deps/Nuanceur || die
	sed -e '/^set(PROJECT_Version/d' -i CMakeLists.txt || die
	{ cd deps/Framework && eapply -p1 "${FILESDIR}/${PN}-framework-system-deps.patch"; } || die
	cmake_src_prepare
}

src_configure() {
	# -DENABLE_AMAZON_S3=$(usex s3) currently broken, must be left ON
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_LIBRETRO_CORE=$(usex libretro)
		-DUSE_GSH_VULKAN=$(usex vulkan)
		-DPROJECT_Version=${PV}
	)
	# https://github.com/jpd002/Play-/issues/911
	append-cppflags -DNDEBUG
	cmake_src_configure
}

src_install() {
	cmake_src_install
	if use libretro; then
		insinto /usr/$(get_libdir)/libretro
		doins "${BUILD_DIR}/Source/ui_libretro/play_libretro.so"
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
