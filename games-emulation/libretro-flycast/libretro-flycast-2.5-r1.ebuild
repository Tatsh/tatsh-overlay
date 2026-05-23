# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils

DESCRIPTION="Multiplatform Sega Dreamcast emulator"
HOMEPAGE="https://github.com/flyinghead/flycast"
SRC_URI="
	https://github.com/flyinghead/flycast/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/libsdl-org/SDL/archive/2359383fc187386204c3bb22de89655a494cd128.tar.gz -> ${P}-core_deps_SDL.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/85c2334e92e215cce34e8e0ed8b2dce4700f4a50.tar.gz -> ${P}-core_deps_Vulkan-Headers.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/6eb62e1515072827db992c2befd80b71b2d04329.tar.gz -> ${P}-core_deps_VulkanMemoryAllocator.tar.gz
	https://github.com/flyinghead/mingw-breakpad/archive/1ab24bcc817ebe629bf77daa53529d02361cb1e9.tar.gz -> ${P}-core_deps_breakpad.tar.gz
	https://github.com/KhronosGroup/glslang/archive/76b52ebf77833908dc4c0dd6c70a9c357ac720bd.tar.gz -> ${P}-core_deps_glslang.tar.gz
	https://github.com/flyinghead/libchdr/archive/5f82799f2c8cad1e9cd26d39a0f8d36369a5534b.tar.gz -> ${P}-core_deps_libchdr.tar.gz
	https://github.com/vinniefalco/LuaBridge/archive/5d21e35633a1f87ed08af115b07d3386096f792b.tar.gz -> ${P}-core_deps_luabridge.tar.gz
	https://github.com/flyinghead/asio/archive/d3402006e84efb6114ff93e4f2b8508412ed80d5.tar.gz -> ${P}-core_deps_asio.tar.gz
"
S="${WORKDIR}/flycast-${PV}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 "
IUSE="gles +opengl vulkan"

REQUIRED_USE="
	|| ( gles opengl )
	opengl? ( !gles )
"

RDEPEND="
	opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/ninja
	dev-build/cmake
"

BUILD_DIR="${WORKDIR}/${P}_build"

src_unpack() {
	unpack "${P}.tar.gz"

	cd "${S}" || die
	local list=(
		core_deps_SDL
		core_deps_Vulkan-Headers
		core_deps_VulkanMemoryAllocator
		core_deps_breakpad
		core_deps_glslang
		core_deps_libchdr
		core_deps_luabridge
		core_deps_asio
	)

	local i
	for i in "${list[@]}"; do
		tar xf "${DISTDIR}/${P}-${i}.tar.gz" --strip-components 1 -C "${i//_//}" ||
			die "Failed to unpack ${P}-${i}.tar.gz"
	done
}

src_configure() {
	mkdir "${BUILD_DIR}"
	pushd  "${BUILD_DIR}" >/dev/null || die

	local mycmakeargs=(
		-DLIBRETRO=ON
		-DUSE_OPENMP=OFF
		-DUSE_GLES2="$(usex gles)"
		-DUSE_VULKAN="$(usex vulkan)"
		"$(usex arm '-DARMv7=ON' '')"
		"$(usex arm64 '-DARM64=ON' '')"
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake "${mycmakeargs[@]}" -GNinja "${S}"

	find . -name flags.make -exec sed -i "s:isystem :I:g" {} \;
	find . -name build.ninja -exec sed -i "s:isystem :I:g" {} \;

	popd >/dev/null || die
}

src_compile() {
	eninja -C "${BUILD_DIR}"
}

src_install() {
	local libretro_lib_dir
	libretro_lib_dir="/usr/$(get_libdir)/libretro"
	exeinto "${libretro_lib_dir}"
	doexe "${BUILD_DIR}"/flycast_libretro.so
}
