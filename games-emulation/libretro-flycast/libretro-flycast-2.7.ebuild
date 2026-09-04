# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils

DESCRIPTION="Multiplatform Sega Dreamcast emulator"
HOMEPAGE="https://github.com/flyinghead/flycast"
SRC_URI="
	https://github.com/flyinghead/flycast/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/libsdl-org/SDL/archive/00d4f1c2c4ad2dc95d26b18743541f57b1dca56d.tar.gz -> ${P}-core_deps_SDL.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/b5c8f996196ba4aa6d8f97e52b5d3b6e70f7e4e2.tar.gz -> ${P}-core_deps_Vulkan-Headers.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/1d8f600fd424278486eade7ed3e877c99f0846b1.tar.gz -> ${P}-core_deps_VulkanMemoryAllocator.tar.gz
	https://github.com/flyinghead/mingw-breakpad/archive/1ab24bcc817ebe629bf77daa53529d02361cb1e9.tar.gz -> ${P}-core_deps_breakpad.tar.gz
	https://github.com/KhronosGroup/glslang/archive/fc9889c889561c5882e83819dcaffef5ed45529b.tar.gz -> ${P}-core_deps_glslang.tar.gz
	https://github.com/flyinghead/libchdr/archive/5f82799f2c8cad1e9cd26d39a0f8d36369a5534b.tar.gz -> ${P}-core_deps_libchdr.tar.gz
	https://github.com/vinniefalco/LuaBridge/archive/5d21e35633a1f87ed08af115b07d3386096f792b.tar.gz -> ${P}-core_deps_luabridge.tar.gz
	https://github.com/flyinghead/asio/archive/d3402006e84efb6114ff93e4f2b8508412ed80d5.tar.gz -> ${P}-core_deps_asio.tar.gz
	https://github.com/flyinghead/tinygettext/archive/41572a67f96013691685a38f0032f3c97aa34f79.tar.gz -> ${P}-core_deps_tinygettext.tar.gz
	https://github.com/Grumbel/tinycmmc/archive/9a51e13802d930feb7261ba8876940659b258cb7.tar.gz -> ${P}-core_deps_tinygettext_external_tinycmmc.tar.gz
	https://github.com/herumi/xbyak/archive/0d67fd1530016b7c56f3cd74b3fca920f4c3e2b4.tar.gz -> ${P}-core_deps_xbyak.tar.gz"
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
		core_deps_tinygettext
		# tinygettext's own submodule; must follow it so the target dir exists.
		core_deps_tinygettext_external_tinycmmc
		core_deps_xbyak
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
