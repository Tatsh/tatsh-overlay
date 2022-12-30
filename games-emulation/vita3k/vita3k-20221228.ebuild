# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Experimental PlayStation Vita emulator."
HOMEPAGE="https://vita3k.org https://github.com/Vita3K/Vita3K"
SHA="0df79bb8b28fdab012a4b471506662d024c802a4"
BETTER_ENUMS_SHA="1e8f499ddff8eec43129ac974eebdfb745920643"
CRYPTO_ALGORITHMS_SHA="cb9ea3fada60f9b01e9133d7db4d3e08171d0565"
DLMALLOC_SHA="e98f4ee160380d7c39dc1f04e7488bcf0770d391"
DYNARMIC_SHA="e97550ada305cd40de0452408ca758ea16742d41"
GOOGLETEST_SHA="71140c3ca7a87bb1b5b9c9f1500fea8858cce344"
IMGUI_SHA="e57871bb95faec757e51214bc0e1ae29b13258ab"
IMGUI_CLUB_SHA="d4cd9896e15a03e92702a578586c3f91bbde01e8"
LIBFAT16_SHA="14ec3073358544c70b77702ff6394f09ce349c59"
PRINTF_SHA="99f2ec5426cf7113a4879048cd772657c84865e3"
STB_SHA="8b5f1f37b5b75829fc72d38e7b5d4bcbf8a26d55"
UNICORN_SHA="66ab1e0ff2de668eaebba33f88ac54d363c866bf"
VITA_TOOLCHAIN_SHA="c938f0ffd94a8d10887a222849287a59ff1e1da9"
VULKAN_MEMORY_ALLOCATOR_HPP_SHA=""
SRC_URI="https://github.com/Vita3K/Vita3K/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/KorewaWatchful/crypto-algorithms/archive/${CRYPTO_ALGORITHMS_SHA}.tar.gz -> crypto-algorithms-${CRYPTO_ALGORITHMS_SHA:0:7}.tar.gz
	https://github.com/Vita3K/dlmalloc/archive/${DLMALLOC_SHA}.tar.gz -> ${PN}-dlmalloc-${DLMALLOC_SHA:0:7}.tar.gz
	https://github.com/Vita3K/libfat16/archive/${LIBFAT16_SHA}.tar.gz -> ${PN}-libfat16-${LIBFAT16_SHA:0:7}.tar.gz
	https://github.com/Vita3K/unicorn/archive/${UNICORN_SHA}.tar.gz -> ${PN}-unicorn-${UNICORN_SHA:0:7}.tar.gz
	https://github.com/aantron/better-enums/archive/${BETTER_ENUMS_SHA}.tar.gz -> better-enums-${SHA:0:7}.tar.gz
	https://github.com/google/googletest/archive/${GOOGLETEST_SHA}.tar.gz -> googletest-${GOOGLETEST_SHA:0:7}.tar.gz
	https://github.com/nothings/stb/archive/${STB_SHA}.tar.gz -> stb-${SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui_club/archive/${IMGUI_CLUB_SHA}.tar.gz -> imgui-club-${IMGUI_CLUB_SHA:0:7}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/cli11
	dev-cpp/yaml-cpp
	dev-libs/boost
	dev-libs/capstone
	dev-libs/libfmt
	dev-libs/openssl
	dev-libs/pugixml
	dev-libs/spdlog
	dev-libs/vulkan-memory-allocator
	dev-libs/xxhash
	dev-util/glslang
	dev-util/spirv-cross
	media-libs/cubeb
	media-libs/libsdl2
	media-video/ffmpeg
	sys-apps/dbus
	sys-libs/zlib

	dev-libs/nativefiledialog-extended
	dev-util/vita-toolchain
	media-libs/libatrac9"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Vita3K-${SHA}"

src_prepare() {
	rmdir external/{better-enums,crypto-algorithms,dlmalloc,googletest,imgui,imgui_club,libfat16,stb,unicorn} || die
	mv "${WORKDIR}/better-enums-${BETTER_ENUMS_SHA}" external/better-enums || die
	mv "${WORKDIR}/crypto-algorithms-${CRYPTO_ALGORITHMS_SHA}" external/crypto-algorithms || die
	mv "${WORKDIR}/dlmalloc-${DLMALLOC_SHA}" external/dlmalloc || die
	mv "${WORKDIR}/libfat16-${LIBFAT16_SHA}" external/libfat16 || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVITA3K_FORCE_SYSTEM_BOOST=ON
		-DUSE_DISCORD_RICH_PRESENCE=OFF
		-DUSE_SYSTEM_FFMPEG=ON
		-DUSE_VITA3K_UPDATE=OFF
	)
	cmake_src_configure
}
