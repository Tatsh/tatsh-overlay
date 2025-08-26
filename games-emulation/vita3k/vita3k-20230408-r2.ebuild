# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop wrapper

DESCRIPTION="Experimental PlayStation Vita emulator."
HOMEPAGE="https://vita3k.org https://github.com/Vita3K/Vita3K"
SHA="b28657ac9721c80c087d87f44595fa3284c7472c"
BETTER_ENUMS_SHA="c35576bed0295689540b39873126129adfa0b4c8"
CRYPTO_ALGORITHMS_SHA="cb9ea3fada60f9b01e9133d7db4d3e08171d0565"
DLMALLOC_SHA="e98f4ee160380d7c39dc1f04e7488bcf0770d391"
_DYNARMIC_SHA="83adf70ded4ea5642fb35da1e2cdc73e898316e7"
FMT_SHA="a33701196adfad74917046096bf5a2aa0ab0bb50"
GLSLANG_SHA="ca8d07d0bc1c6390b83915700439fa7719de6a2a"
IMGUI_SHA="9aae45eb4a05a5a1f96be1ef37eb503a12ceb889"
IMGUI_CLUB_SHA="d4cd9896e15a03e92702a578586c3f91bbde01e8"
LIBATRAC9_SHA="82767fe38823c32536726ea798f392b0b49e66b9"
LIBB64_SHA="3896b7a74c70baed0e2f6039a1dbd723e5d5cc8f"
LIBFAT16_SHA="14ec3073358544c70b77702ff6394f09ce349c59"
LIBZRIF_SHA="7d1e69bee7d2f08ea5754eff4463c041aacd49af"
PRINTF_SHA="99f2ec5426cf7113a4879048cd772657c84865e3"
PSVPFSPARSER_SHA="a5e7cbbd4ba21d1a7d4018866fd5a605644731a4"
SPDLOG_SHA="da14258533cb951ce85087ceb45556e0b8253660"
SPIRV_CROSS_SHA="4e2fdb25671c742a9fbe93a6034eb1542244c7e1"
STB_SHA="af1a5bc352164740c1cc1354942b1c6b72eacb8a"
UNICORN_SHA="4b52942ba9d13437c1a858f3ace279db88d7089a"
VITA_TOOLCHAIN_SHA="1ce9a316eedb0360d55b3d9a6483e5329c781583"
VULKANMEMORYALLOCATOR_HPP_SHA="dad10c8ff7a9a18836d00026824b85745a02f1c2"
SRC_URI="https://github.com/Vita3K/Vita3K/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Cross/archive/${SPIRV_CROSS_SHA}.tar.gz -> SPIRV-Cross-${SPIRV_CROSS_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SHA}.tar.gz -> glslang-${GLSLANG_SHA:0:7}.tar.gz
	https://github.com/KorewaWatchful/crypto-algorithms/archive/${CRYPTO_ALGORITHMS_SHA}.tar.gz -> crypto-algorithms-${CRYPTO_ALGORITHMS_SHA:0:7}.tar.gz
	https://github.com/KorewaWatchful/libzRIF/archive/${LIBZRIF_SHA}.tar.gz -> libzrif-${LIBZRIF_SHA:0:7}.tar.gz
	https://github.com/Macdu/VulkanMemoryAllocator-Hpp/archive/${VULKANMEMORYALLOCATOR_HPP_SHA}.tar.gz -> VulkanMemoryAllocator-Hpp-${VULKANMEMORYALLOCATOR_HPP_SHA:0:7}.tar.gz
	https://github.com/Vita3k/LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz -> ${PN}-libatrac9-${LIBATRAC9_SHA:0:7}.tar.gz
	https://github.com/Vita3K/dlmalloc/archive/${DLMALLOC_SHA}.tar.gz -> ${PN}-dlmalloc-${DLMALLOC_SHA:0:7}.tar.gz
	https://github.com/Vita3K/libfat16/archive/${LIBFAT16_SHA}.tar.gz -> ${PN}-libfat16-${LIBFAT16_SHA:0:7}.tar.gz
	https://github.com/Vita3K/printf/archive/${PRINTF_SHA}.tar.gz -> vita3k-printf-${PRINTF_SHA:0:7}.tar.gz
	https://github.com/Vita3K/psvpfsparser/archive/${PSVPFSPARSER_SHA}.tar.gz -> psvpfsparser-${PSVPFSPARSER_SHA:0:7}.tar.gz
	https://github.com/Vita3K/unicorn/archive/${UNICORN_SHA}.tar.gz -> ${PN}-unicorn-${UNICORN_SHA:0:7}.tar.gz
	https://github.com/aantron/better-enums/archive/${BETTER_ENUMS_SHA}.tar.gz -> better-enums-${SHA:0:7}.tar.gz
	https://github.com/fmtlib/fmt/archive/${FMT_SHA}.tar.gz -> fmt-${FMT_SHA:0:7}.tar.gz
	https://github.com/gabime/spdlog/archive/${SPDLOG_SHA}.tar.gz -> spdlog-${SPDLOG_SHA:0:7}.tar.gz
	https://github.com/nothings/stb/archive/${STB_SHA}.tar.gz -> stb-${SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui_club/archive/${IMGUI_CLUB_SHA}.tar.gz -> imgui-club-${IMGUI_CLUB_SHA:0:7}.tar.gz
	https://github.com/Vita3K/dynarmic/archive/${_DYNARMIC_SHA}.tar.gz -> dynarmic-${_DYNARMIC_SHA:0:7}.tar.gz
	https://github.com/KorewaWatchful/libb64/archive/${LIBB64_SHA}.tar.gz -> libb64-${LIBB64_SHA:0:7}.tar.gz
	https://github.com/vitasdk/vita-toolchain/archive/${VITA_TOOLCHAIN_SHA}.tar.gz -> vita-toolchain-${VITA_TOOLCHAIN_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-cpp/cli11
	dev-cpp/tracy
	dev-cpp/yaml-cpp
	dev-libs/boost
	dev-libs/capstone
	dev-libs/libtomcrypt
	dev-libs/nativefiledialog-extended
	dev-libs/openssl
	dev-libs/pugixml
	media-libs/VulkanMemoryAllocator
	dev-libs/xxhash
	media-libs/cubeb
	media-libs/libsdl2
	media-video/ffmpeg
	sys-apps/dbus
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Vita3K-${SHA}"

PATCHES=(
	"${FILESDIR}/${PN}-0001-system-libs.patch"
	"${FILESDIR}/${PN}-0002-fix-linking-of-libhttps.patch"
	"${FILESDIR}/${PN}-psvpfsparser-link.patch"
	"${FILESDIR}/${PN}-gcc-13.patch"
)

src_prepare() {
	rmdir external/{better-enums,crypto-algorithms,dlmalloc,imgui,imgui_club,libfat16,stb,unicorn,SPIRV-Cross,glslang,VulkanMemoryAllocator-Hpp,LibAtrac9,printf,fmt,spdlog,vita-toolchain,dynarmic} || die
	mv "${WORKDIR}/LibAtrac9-${LIBATRAC9_SHA}" external/LibAtrac9 || die
	mv "${WORKDIR}/SPIRV-Cross-${SPIRV_CROSS_SHA}" external/SPIRV-Cross || die
	mv "${WORKDIR}/VulkanMemoryAllocator-Hpp-${VULKANMEMORYALLOCATOR_HPP_SHA}" external/VulkanMemoryAllocator-Hpp || die
	mv "${WORKDIR}/better-enums-${BETTER_ENUMS_SHA}" external/better-enums || die
	mv "${WORKDIR}/crypto-algorithms-${CRYPTO_ALGORITHMS_SHA}" external/crypto-algorithms || die
	mv "${WORKDIR}/dlmalloc-${DLMALLOC_SHA}" external/dlmalloc || die
	mv "${WORKDIR}/dynarmic-${_DYNARMIC_SHA}" external/dynarmic || die
	mv "${WORKDIR}/fmt-${FMT_SHA}" external/fmt || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" external/glslang || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" external/imgui || die
	mv "${WORKDIR}/imgui_club-${IMGUI_CLUB_SHA}" external/imgui_club || die
	mv "${WORKDIR}/libb64-${LIBB64_SHA}" external/libb64 || die
	mv "${WORKDIR}/libfat16-${LIBFAT16_SHA}" external/libfat16 || die
	mv "${WORKDIR}/libzRIF-${LIBZRIF_SHA}" external/libzrif || die
	mv "${WORKDIR}/printf-${PRINTF_SHA}" external/printf || die
	mv "${WORKDIR}/psvpfsparser-${PSVPFSPARSER_SHA}" external/psvpfsparser || die
	mv "${WORKDIR}/spdlog-${SPDLOG_SHA}" external/spdlog || die
	mv "${WORKDIR}/stb-${STB_SHA}" external/stb || die
	mv "${WORKDIR}/unicorn-${UNICORN_SHA}" external/unicorn || die
	mv "${WORKDIR}/vita-toolchain-${VITA_TOOLCHAIN_SHA}" external/vita-toolchain || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVITA3K_FORCE_SYSTEM_BOOST=ON
		-DUSE_DISCORD_RICH_PRESENCE=OFF
		-DUSE_VITA3K_UPDATE=OFF
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_install() {
	local -r common_root="/usr/$(get_libdir)/${PN}"
	exeinto "$common_root"
	doexe "${BUILD_DIR}/bin/Vita3K"
	insinto "$common_root"
	doins -r "${BUILD_DIR}/bin/"{data,lang,shaders-builtin}
	newicon -s 128 "${BUILD_DIR}/bin/data/image/icon.png" "${PN}.png"
	make_wrapper Vita3K "${common_root}/Vita3K" "$common_root"
	make_desktop_entry Vita3K Vita3K
	einstalldocs
}
