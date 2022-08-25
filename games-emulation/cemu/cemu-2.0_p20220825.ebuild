# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Wii U emulator."
HOMEPAGE="https://cemu.info/ https://github.com/cemu-project/Cemu"
SHA="a2abffd37b9ce62d8d5d52031ec6c56a7fd03938"
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
	x11-libs/wxGTK:3.0-gtk3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${SHA}"

src_configure() {
	AR=llvm-ar
	CC=${CHOST}-clang
	CXX=${CHOST}-clang++
	OBJCOPY=llvm-objcopy
	OBJDUMP=llvm-objdump
	NM=llvm-nm
	RANLIB=llvm-ranlib
	tc-export CC CXX LD AR NM OBJDUMP OBJCOPY RANLIB
	local mycmakeargs=(
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=$(usex lto)
		-DENABLE_CUBEB=ON
		-DENABLE_DISCORD_RPC=OFF
		-DENABLE_OPENGL=ON
		-DENABLE_SDL=ON
		-DENABLE_VULKAN=ON
		-DENABLE_WXWIDGETS=ON
	)
	cmake_src_configure
}
