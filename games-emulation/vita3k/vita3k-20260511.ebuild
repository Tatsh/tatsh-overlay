# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="Experimental PlayStation Vita emulator."
HOMEPAGE="
	https://vita3k.org
	https://github.com/Vita3K/Vita3K
" 
SHA="9abe85f90ff04f397a817beef03f3fafd5e6900f"
LIBATRAC9_SHA="82767fe38823c32536726ea798f392b0b49e66b9"
SPIRV_CROSS_SHA="d8e3e2b141b8c8a167b2e3984736a6baacff316c"
VULKANMEMORYALLOCATOR_HPP_SHA="2059f0fdd73492b03d60a90c73e5038224b99093"
VULKANMEMORYALLOCATOR_HPP_VULKAN_HEADERS_SHA="952f776f6573aafbb62ea717d871cd1d6816c387"
VULKANMEMORYALLOCATOR_HPP_VULKANMEMORYALLOCATOR_SHA="c788c52156f3ef7bc7ab769cb03c110a53ac8fcb"
BETTER_ENUMS_SHA="c35576bed0295689540b39873126129adfa0b4c8"
CONCURRENTQUEUE_SHA="6dd38b8a1dbaa7863aa907045f32308a56a6ff5d"
DIRENT_SHA="39c1f1bc98ef3326237d03006f35d7dd44620e43"
DLMALLOC_SHA="e98f4ee160380d7c39dc1f04e7488bcf0770d391"
_DYNARMIC_SHA="86458a0bd369d63ba4c2ef812cacbb6c9080c065"
GLSLANG_SHA="fc9889c889561c5882e83819dcaffef5ed45529b"
GOOGLETEST_SHA="6910c9d9165801d8827d628cb72eb7ea9dd538c5"
IMGUI_SHA="cb16568fca5297512ff6a8f3b877f461c4323fbe"
IMGUI_CLUB_SHA="53a2df3dd1b19dd321beb0897a0d1b9f87e5429c"
LIBADRENOTOOLS_SHA="8fae8ce254dfc1344527e05301e43f37dea2df80"
LIBADRENOTOOLS_LIB_LINKERNSBYPASS_SHA="aa3975893d83ef1bc84c321ec60c65fbf1287887"
LIBFAT16_SHA="d9a890b712dcdb46d3d33230997efc59f5ad8d62"
PRINTF_SHA="c75def6db38f9978c55e8d27227858df911cd727"
PSVPFSTOOLS_SHA="ab1aa9b36388843f6a9f8dc86b1746f1f2a7e557"
PSVPFSTOOLS_LIBB64_SHA="3896b7a74c70baed0e2f6039a1dbd723e5d5cc8f"
PSVPFSTOOLS_LIBZRIF_SHA="7d1e69bee7d2f08ea5754eff4463c041aacd49af"
PSVPFSTOOLS_PSVPFSPARSER_SHA="4094450bcaac2256236d61ae3a730425ae47bd39"
PSVPFSTOOLS_ZLIB_SHA="cb210089eb06453199578993566012493f6f7d21"
SUBSTITUTE_SHA="319da6b563d8da689f3b9df2fbb839edd41a1943"
VITA_TOOLCHAIN_SHA="77f17b979678e7af0acfe708dc97a45ca6fd55e2"
VITA_TOOLCHAIN_PSP2RELA_SHA="9e0f4913866431aef48967cfb7667b085e79428b"

SRC_URI="https://github.com/Vita3K/Vita3K/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/Vita3K/LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz -> ${PN}-LibAtrac9-82767fe.tar.gz
	https://github.com/KhronosGroup/SPIRV-Cross/archive/${SPIRV_CROSS_SHA}.tar.gz -> ${PN}-SPIRV-Cross-d8e3e2b.tar.gz
	https://github.com/YaaZ/VulkanMemoryAllocator-Hpp/archive/${VULKANMEMORYALLOCATOR_HPP_SHA}.tar.gz -> ${PN}-VulkanMemoryAllocator-Hpp-2059f0f.tar.gz
	https://github.com/KhronosGroup/Vulkan-Headers/archive/${VULKANMEMORYALLOCATOR_HPP_VULKAN_HEADERS_SHA}.tar.gz -> ${PN}-VulkanMemoryAllocator-Hpp-Vulkan-Headers-952f776.tar.gz
	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator/archive/${VULKANMEMORYALLOCATOR_HPP_VULKANMEMORYALLOCATOR_SHA}.tar.gz -> ${PN}-VulkanMemoryAllocator-Hpp-VulkanMemoryAllocator-c788c52.tar.gz
	https://github.com/aantron/better-enums/archive/${BETTER_ENUMS_SHA}.tar.gz -> ${PN}-better-enums-c35576b.tar.gz
	https://github.com/cameron314/concurrentqueue/archive/${CONCURRENTQUEUE_SHA}.tar.gz -> ${PN}-concurrentqueue-6dd38b8.tar.gz
	https://github.com/tronkko/dirent/archive/${DIRENT_SHA}.tar.gz -> ${PN}-dirent-39c1f1b.tar.gz
	https://github.com/Vita3K/dlmalloc/archive/${DLMALLOC_SHA}.tar.gz -> ${PN}-dlmalloc-e98f4ee.tar.gz
	https://github.com/Vita3K/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> ${PN}-dynarmic-86458a0.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SHA}.tar.gz -> ${PN}-glslang-fc9889c.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> ${PN}-googletest-6910c9d.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-cb16568.tar.gz
	https://github.com/ocornut/imgui_club/archive/${IMGUI_CLUB_SHA}.tar.gz -> ${PN}-imgui_club-53a2df3.tar.gz
	https://github.com/bylaws/libadrenotools/archive/${LIBADRENOTOOLS_SHA}.tar.gz -> ${PN}-libadrenotools-8fae8ce.tar.gz
	https://github.com/bylaws/liblinkernsbypass/archive/${LIBADRENOTOOLS_LIB_LINKERNSBYPASS_SHA}.tar.gz -> ${PN}-libadrenotools-lib-linkernsbypass-aa39758.tar.gz
	https://github.com/Vita3K/libfat16/archive/${LIBFAT16_SHA}.tar.gz -> ${PN}-libfat16-d9a890b.tar.gz
	https://github.com/Vita3K/printf/archive/${PRINTF_SHA}.tar.gz -> ${PN}-printf-c75def6.tar.gz
	https://github.com/Vita3K/psvpfstools/archive/${PSVPFSTOOLS_SHA}.tar.gz -> ${PN}-psvpfstools-ab1aa9b.tar.gz
	https://github.com/korewawatchful/libb64/archive/${PSVPFSTOOLS_LIBB64_SHA}.tar.gz -> ${PN}-psvpfstools-libb64-3896b7a.tar.gz
	https://github.com/KorewaWatchful/libzrif/archive/${PSVPFSTOOLS_LIBZRIF_SHA}.tar.gz -> ${PN}-psvpfstools-libzrif-7d1e69b.tar.gz
	https://github.com/Vita3K/psvpfsparser/archive/${PSVPFSTOOLS_PSVPFSPARSER_SHA}.tar.gz -> ${PN}-psvpfstools-psvpfsparser-4094450.tar.gz
	https://github.com/korewawatchful/zlib/archive/${PSVPFSTOOLS_ZLIB_SHA}.tar.gz -> ${PN}-psvpfstools-zlib-cb21008.tar.gz
	https://github.com/Vita3K/substitute/archive/${SUBSTITUTE_SHA}.tar.gz -> ${PN}-substitute-319da6b.tar.gz
	https://github.com/vitasdk/vita-toolchain/archive/${VITA_TOOLCHAIN_SHA}.tar.gz -> ${PN}-vita-toolchain-77f17b9.tar.gz
	https://github.com/Princess-of-Sleeping/psp2rela/archive/${VITA_TOOLCHAIN_PSP2RELA_SHA}.tar.gz -> ${PN}-vita-toolchain-psp2rela-9e0f491.tar.gz
"

S="${WORKDIR}/Vita3K-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=dev-libs/boost-1.81:=
	dev-cpp/tracy
	dev-cpp/yaml-cpp
	dev-libs/capstone:=
	dev-libs/libfmt:=
	dev-libs/nativefiledialog-extended
	dev-libs/openssl
	dev-libs/pugixml
	dev-libs/spdlog
	dev-libs/xxhash
	media-libs/cubeb
	media-libs/libsdl3
	media-libs/stb
	media-video/ffmpeg:=
	sys-apps/dbus
	virtual/zlib"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-allow-shared-system-boost-on.patch"
	"${FILESDIR}/${PN}-0002-honor-xdg-base-directory-spe.patch"
	"${FILESDIR}/${PN}-0003-add-cmake-install-rules-for-.patch"
	"${FILESDIR}/${PN}-0004-skip-empty-boost-submodule-c.patch"
	"${FILESDIR}/${PN}-0005-add-use_system_ffmpeg-opt-in.patch"
	"${FILESDIR}/${PN}-0006-codec-use-public-ffmpeg-api-.patch"
	"${FILESDIR}/${PN}-0007-add-use_system_stb-opt-in-fo.patch"
	"${FILESDIR}/${PN}-0008-add-use_system_fmt-opt-in-fo.patch"
	"${FILESDIR}/${PN}-0009-add-use_system_sdl3-opt-in-f.patch"
	"${FILESDIR}/${PN}-0010-add-use_system_capstone-opt-.patch"
	"${FILESDIR}/${PN}-0011-add-use_system_tracy-opt-in-.patch"
	"${FILESDIR}/${PN}-0012-add-use_system_pugixml-opt-i.patch"
	"${FILESDIR}/${PN}-0013-add-use_system_yaml_cpp-opt-.patch"
	"${FILESDIR}/${PN}-0014-add-use_system_spdlog-opt-in.patch"
	"${FILESDIR}/${PN}-0015-add-use_system_xxhash-opt-in.patch"
	"${FILESDIR}/${PN}-0016-fall-back-to-xxhash.h-inline.patch"
	"${FILESDIR}/${PN}-0017-add-use_system_nfde-opt-in-f.patch"
	"${FILESDIR}/${PN}-0018-add-use_system_cubeb-opt-in-.patch"
	"${FILESDIR}/${PN}-0019-force-the-bundled-xbyak-syst.patch"
)

src_prepare() {
	rm -rf "${S}/external/LibAtrac9" || die
	mv "${WORKDIR}/LibAtrac9-${LIBATRAC9_SHA}" "${S}/external/LibAtrac9" || die
	rm -rf "${S}/external/SPIRV-Cross" || die
	mv "${WORKDIR}/SPIRV-Cross-${SPIRV_CROSS_SHA}" "${S}/external/SPIRV-Cross" || die
	rm -rf "${S}/external/VulkanMemoryAllocator-Hpp" || die
	mv "${WORKDIR}/VulkanMemoryAllocator-Hpp-${VULKANMEMORYALLOCATOR_HPP_SHA}" "${S}/external/VulkanMemoryAllocator-Hpp" || die
	rm -rf "${S}/external/better-enums" || die
	mv "${WORKDIR}/better-enums-${BETTER_ENUMS_SHA}" "${S}/external/better-enums" || die
	rm -rf "${S}/external/concurrentqueue" || die
	mv "${WORKDIR}/concurrentqueue-${CONCURRENTQUEUE_SHA}" "${S}/external/concurrentqueue" || die
	rm -rf "${S}/external/dirent" || die
	mv "${WORKDIR}/dirent-${DIRENT_SHA}" "${S}/external/dirent" || die
	rm -rf "${S}/external/dlmalloc" || die
	mv "${WORKDIR}/dlmalloc-${DLMALLOC_SHA}" "${S}/external/dlmalloc" || die
	rm -rf "${S}/external/dynarmic" || die
	mv "${WORKDIR}/dynarmic-${_DYNARMIC_SHA}" "${S}/external/dynarmic" || die
	rm -rf "${S}/external/glslang" || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" "${S}/external/glslang" || die
	rm -rf "${S}/external/googletest" || die
	mv "${WORKDIR}/googletest-${GOOGLETEST_SHA}" "${S}/external/googletest" || die
	rm -rf "${S}/external/imgui" || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" "${S}/external/imgui" || die
	rm -rf "${S}/external/imgui_club" || die
	mv "${WORKDIR}/imgui_club-${IMGUI_CLUB_SHA}" "${S}/external/imgui_club" || die
	rm -rf "${S}/external/libadrenotools" || die
	mv "${WORKDIR}/libadrenotools-${LIBADRENOTOOLS_SHA}" "${S}/external/libadrenotools" || die
	rm -rf "${S}/external/libfat16" || die
	mv "${WORKDIR}/libfat16-${LIBFAT16_SHA}" "${S}/external/libfat16" || die
	rm -rf "${S}/external/printf" || die
	mv "${WORKDIR}/printf-${PRINTF_SHA}" "${S}/external/printf" || die
	rm -rf "${S}/external/psvpfstools" || die
	mv "${WORKDIR}/psvpfstools-${PSVPFSTOOLS_SHA}" "${S}/external/psvpfstools" || die
	rm -rf "${S}/external/substitute" || die
	mv "${WORKDIR}/substitute-${SUBSTITUTE_SHA}" "${S}/external/substitute" || die
	rm -rf "${S}/external/vita-toolchain" || die
	mv "${WORKDIR}/vita-toolchain-${VITA_TOOLCHAIN_SHA}" "${S}/external/vita-toolchain" || die
	rm -rf "${S}/external/VulkanMemoryAllocator-Hpp/Vulkan-Headers" || die
	mv "${WORKDIR}/Vulkan-Headers-${VULKANMEMORYALLOCATOR_HPP_VULKAN_HEADERS_SHA}" "${S}/external/VulkanMemoryAllocator-Hpp/Vulkan-Headers" || die
	rm -rf "${S}/external/VulkanMemoryAllocator-Hpp/VulkanMemoryAllocator" || die
	mv "${WORKDIR}/VulkanMemoryAllocator-${VULKANMEMORYALLOCATOR_HPP_VULKANMEMORYALLOCATOR_SHA}" "${S}/external/VulkanMemoryAllocator-Hpp/VulkanMemoryAllocator" || die
	rm -rf "${S}/external/psvpfstools/libb64" || die
	mv "${WORKDIR}/libb64-${PSVPFSTOOLS_LIBB64_SHA}" "${S}/external/psvpfstools/libb64" || die
	rm -rf "${S}/external/psvpfstools/libzrif" || die
	mv "${WORKDIR}/libzRIF-${PSVPFSTOOLS_LIBZRIF_SHA}" "${S}/external/psvpfstools/libzrif" || die
	rm -rf "${S}/external/psvpfstools/psvpfsparser" || die
	mv "${WORKDIR}/psvpfsparser-${PSVPFSTOOLS_PSVPFSPARSER_SHA}" "${S}/external/psvpfstools/psvpfsparser" || die
	rm -rf "${S}/external/psvpfstools/zlib" || die
	mv "${WORKDIR}/zlib-${PSVPFSTOOLS_ZLIB_SHA}" "${S}/external/psvpfstools/zlib" || die
	rm -rf "${S}/external/vita-toolchain/psp2rela" || die
	mv "${WORKDIR}/psp2rela-${VITA_TOOLCHAIN_PSP2RELA_SHA}" "${S}/external/vita-toolchain/psp2rela" || die
	rm -rf "${S}/external/libadrenotools/lib/linkernsbypass" || die
	mv "${WORKDIR}/liblinkernsbypass-${LIBADRENOTOOLS_LIB_LINKERNSBYPASS_SHA}" "${S}/external/libadrenotools/lib/linkernsbypass" || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DUSE_DISCORD_RICH_PRESENCE=OFF
		-DUSE_VITA3K_UPDATE=OFF
		-DVITA3K_FORCE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CAPSTONE=ON
		-DUSE_SYSTEM_CUBEB=ON
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_NFDE=ON
		-DUSE_SYSTEM_SDL3=ON
		-DUSE_SYSTEM_SPDLOG=ON
		-DUSE_SYSTEM_STB=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_TRACY=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_YAML_CPP=ON
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	DESTDIR="${D}" cmake --install "${BUILD_DIR}" --component vita3k || die
	einstalldocs
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
