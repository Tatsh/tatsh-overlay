# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Wii U emulator."
HOMEPAGE="https://cemu.info/ https://github.com/cemu-project/Cemu"
SHA="454b587e3625aa4b8204101d1eb52894f0da0829"
MY_PN="Cemu"
SRC_URI="https://github.com/cemu-project/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+clang lto"

BDEPEND="sys-devel/clang:="
DEPEND="app-arch/zarchive
	app-arch/zstd
	dev-libs/boost
	dev-libs/libzip
	dev-libs/openssl
	dev-libs/pugixml
	dev-libs/rapidjson
	dev-util/glslang
	dev-util/vulkan-headers
	media-libs/cubeb
	media-libs/libsdl2[joystick,threads]
	net-misc/curl
	sys-libs/zlib
	x11-libs/wxGTK:3.2-gtk3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${SHA}"

PATCHES=( "${FILESDIR}/${PN}-deps.patch" )

src_prepare() {
	cmake_src_prepare
	sed -re '/^find_package\(glslang.*/d' -i CMakeLists.txt || die
	sed -re 's/pugixml::static//g' -e 's/SDL2::SDL2main//g' -i src/CMakeLists.txt || die
	sed -re 's/glslang::SPIRV/SPIRV/g' -i src/Cafe/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=$(usex lto)
		-DENABLE_CUBEB=ON
		-DENABLE_DISCORD_RPC=OFF
		-DENABLE_OPENGL=ON
		-DENABLE_SDL=ON
		-DENABLE_VULKAN=ON
		-DENABLE_WXWIDGETS=ON
		-DwxWidgets_CONFIG_EXECUTABLE=/usr/$(get_libdir)/wx/config/gtk3-unicode-3.2-gtk3
		-Wno-dev
	)
	cmake_src_configure
}
