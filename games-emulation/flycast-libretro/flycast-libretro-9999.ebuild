# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multiprocessing

DESCRIPTION="Multiplatform Sega Dreamcast emulator"
HOMEPAGE="https://github.com/flyinghead/flycast"
EGIT_REPO_URI="https://github.com/flyinghead/flycast"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gles +opengl vulkan"

REQUIRED_USE="
	|| ( gles opengl )
	opengl? ( !gles )
"

RDEPEND="
	opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader )
	gles? ( media-libs/mesa[opengl] )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-build/ninja
	dev-build/cmake
"

BUILD_DIR="${WORKDIR}/${P}_build"

src_configure() {
	mkdir "${BUILD_DIR}"
	pushd  "${BUILD_DIR}"

	local mycmakeargs=(
		-DLIBRETRO=ON
		-DUSE_OPENMP=OFF
		-DUSE_GLES2=$(usex gles)
		-DUSE_VULKAN=$(usex vulkan)
		$(usex arm "-DARMv7=ON" "")
		$(usex arm64 "-DARM64=ON" "")
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake "${mycmakeargs[@]}" -GNinja "${S}"
	find . -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
	find . -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;

	popd
}

src_compile() {
	pushd "${BUILD_DIR}"

	ninja -v ${makeopts_jobs}

	popd
}

src_install() {
	local libretro_lib_dir="/usr/$(get_libdir)/libretro"
	exeinto "${libretro_lib_dir}"
	doexe "${BUILD_DIR}"/flycast_libretro.so
}
