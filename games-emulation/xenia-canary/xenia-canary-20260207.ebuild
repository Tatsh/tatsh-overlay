# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop

DESCRIPTION="Xbox 360 emulator research project (Canary version)."
HOMEPAGE="https://github.com/xenia-canary/xenia-canary https://xenia.jp/"
SHA="ef65c6761bcfa16ab40101ee229c2b88e47251e2"
AES_128_SHA="7e3ac3bb6b478187472b4ac6f1698eb203e8e90b"
BINUTILS_PPC_CYGWIN_SHA="6f3f15db908d339472db7be450f7c58bb71545cc"
DATE_SHA="f94b8f36c6180be0021876c4a397a054fe50c6f2"
FIDELITYFX_CAS_SHA="9fabcc9a2c45f958aff55ddfda337e74ef894b7f"
FIDELITYFX_FSR_SHA="a21ffb8f6c13233ba336352bdff293894c706575"
PREMAKE_ANDROIDNDK_SHA="35a6955410a34840c9d091f071c46cd3e5280fb7"
PREMAKE_CMAKE_SHA="91c646f638a6fbff20f0ea90769df8dcf62bc5e4"
PREMAKE_CORE_SHA="ba2c383c0456aa75d1b93faf62f4aec2691f23b2"
PREMAKE_EXPORT_CC_SHA="59e3e55df8dd87eea70556f50d172a17f1c4b6d0"
DISRUPTORPLUS_SHA="302b6e03e829c6d6a70415f10d818a5088cb6ccf"
FFMPEG_SHA="85e39939c90f3b34efe45fee29a2b653d06b55e5"
GLSLANG_SHA="ae2a562936cc8504c9ef2757cceaff163147834f"
SPIRV_TOOLS_SHA="4451f6ab13dda98bf255a7cd7b4d120132dc0dfd"
RAPIDCSV_SHA="a98b85e663114b8fdc9c0dc03abf22c296f38241"
TABULATE_SHA="3a58301067bbc03da89ae5a51b3e05b7da719d38"
SRC_URI="https://github.com/xenia-canary/xenia-canary/archive/${SHA}.tar.gz
		-> ${P}-${SHA:0:7}.tar.gz
	https://github.com/openluopworld/aes_128/archive/${AES_128_SHA}.tar.gz
		-> ${PN}-aes_128-${AES_128_SHA:0:7}.tar.gz
	https://github.com/benvanik/binutils-ppc-cygwin/archive/${BINUTILS_PPC_CYGWIN_SHA}.tar.gz
		-> ${PN}-binutils-ppc-cygwin-${BINUTILS_PPC_CYGWIN_SHA:0:7}.tar.gz
	https://github.com/HowardHinnant/date/archive/${DATE_SHA}.tar.gz
		-> ${PN}-date-${DATE_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-CAS/archive/${FIDELITYFX_CAS_SHA}.tar.gz
		-> ${PN}-FidelityFX-CAS-${FIDELITYFX_CAS_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-FSR/archive/${FIDELITYFX_FSR_SHA}.tar.gz
		-> ${PN}-FidelityFX-FSR-${FIDELITYFX_FSR_SHA:0:7}.tar.gz
	https://github.com/Triang3l/premake-androidndk/archive/${PREMAKE_ANDROIDNDK_SHA}.tar.gz
		-> ${PN}-premake-androidndk-${PREMAKE_ANDROIDNDK_SHA:0:7}.tar.gz
	https://github.com/JoelLinn/premake-cmake/archive/${PREMAKE_CMAKE_SHA}.tar.gz
		-> ${PN}-premake-cmake-${PREMAKE_CMAKE_SHA:0:7}.tar.gz
	https://github.com/premake/premake-core/archive/${PREMAKE_CORE_SHA}.tar.gz
		-> ${PN}-premake-core-${PREMAKE_CORE_SHA:0:7}.tar.gz
	https://github.com/xenia-project/premake-export-compile-commands/archive/${PREMAKE_EXPORT_CC_SHA}.tar.gz
		-> ${PN}-premake-export-compile-commands-${PREMAKE_EXPORT_CC_SHA:0:7}.tar.gz
	https://github.com/xenia-canary/disruptorplus/archive/${DISRUPTORPLUS_SHA}.tar.gz
		-> ${PN}-disruptorplus-${DISRUPTORPLUS_SHA:0:7}.tar.gz
	https://github.com/xenia-canary/FFmpeg_radixsplit/archive/${FFMPEG_SHA}.tar.gz
		-> ${PN}-FFmpeg-${FFMPEG_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SHA}.tar.gz
		-> ${PN}-glslang-${GLSLANG_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/SPIRV-Tools/archive/${SPIRV_TOOLS_SHA}.tar.gz
		-> ${PN}-SPIRV-Tools-${SPIRV_TOOLS_SHA:0:7}.tar.gz
	https://github.com/d99kris/rapidcsv/archive/${RAPIDCSV_SHA}.tar.gz
		-> ${PN}-rapidcsv-${RAPIDCSV_SHA:0:7}.tar.gz
	https://github.com/p-ranav/tabulate/archive/${TABULATE_SHA}.tar.gz
		-> ${PN}-tabulate-${TABULATE_SHA:0:7}.tar.gz"
S="${WORKDIR}/xenia-canary-${SHA}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx discord"
REQUIRED_USE="cpu_flags_x86_avx"

DEPEND="app-arch/brotli
	app-arch/bzip2
	app-arch/snappy
	app-arch/zarchive
	app-arch/zstd
	dev-cpp/tomlplusplus
	dev-libs/capstone
	dev-libs/expat
	dev-libs/libfmt:=
	dev-libs/libpcre2
	dev-libs/pugixml
	dev-libs/xxhash
	discord? ( dev-libs/discord-rpc )
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/imgui
	media-libs/libjpeg-turbo:=
	media-libs/libpulse
	media-libs/libsdl2
	media-libs/libsndfile
	media-libs/vulkan-loader
	media-video/pipewire
	sys-apps/util-linux
	sys-libs/zlib-ng
	x11-libs/gtk+"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/cxxopts
	dev-libs/utfcpp
	dev-libs/xbyak
	dev-util/directx-headers
	dev-util/premake:5
	dev-util/vulkan-headers
	llvm-core/clang
	media-libs/VulkanMemoryAllocator"

PATCHES=(
	"${FILESDIR}/${PN}-0001-use_system_xxhash.patch"
	"${FILESDIR}/${PN}-0002-build-treat-wunused-result-a.patch"
	"${FILESDIR}/${PN}-0003-build-generate-build-version.patch"
	"${FILESDIR}/${PN}-0004-build-fix-linux-linker-error.patch"
	"${FILESDIR}/${PN}-0005-build-add-use_system_fmt-opt.patch"
	"${FILESDIR}/${PN}-0006-build-add-use_system_zstd-an.patch"
	"${FILESDIR}/${PN}-0007-use_system_glslang.patch"
	"${FILESDIR}/${PN}-0008-build-add-use_system_capston.patch"
	"${FILESDIR}/${PN}-0009-add-use_system_snappy-option.patch"
	"${FILESDIR}/${PN}-0010-add-use_system_pugixml-optio.patch"
	"${FILESDIR}/${PN}-0011-add-use_system_zlib_ng-optio.patch"
	"${FILESDIR}/${PN}-0012-add-use_system_cxxopts-optio.patch"
	"${FILESDIR}/${PN}-0013-add-use_system_xbyak-option-.patch"
	"${FILESDIR}/${PN}-0014-add-use_system_tomlplusplus-.patch"
	"${FILESDIR}/${PN}-0015-use_system_utfcpp.patch"
	"${FILESDIR}/${PN}-0016-add-use_system_vulkan_header.patch"
	"${FILESDIR}/${PN}-0017-discord.patch"
	"${FILESDIR}/${PN}-0018-add-use_system_imgui-option-.patch"
	"${FILESDIR}/${PN}-0019-use-system-sdl2-on-linux.patch"
	"${FILESDIR}/${PN}-0020-zarchive-sha_256-guard-system.patch"
	"${FILESDIR}/${PN}-0021-use-system-premake.patch"
	"${FILESDIR}/${PN}-0022-allow-version-override.patch"
	"${FILESDIR}/${PN}-0023-gentoo-cflags.patch"
	"${FILESDIR}/${PN}-0024-cmake-relwithdebinfo.patch"
)

CMAKE_USE_DIR="${S}/build"

xenia_env() {
	# Upstream only supports Clang.
	export CC=${CHOST}-clang CXX=${CHOST}-clang++
	export USE_SYSTEM_CAPSTONE=1
	export USE_SYSTEM_CXXOPTS=1
	export USE_SYSTEM_DISCORD_RPC=$(usex discord 1 0)
	export USE_SYSTEM_FMT=1
	export USE_SYSTEM_IMGUI=1
	export USE_SYSTEM_PUGIXML=1
	export USE_SYSTEM_SNAPPY=1
	export USE_SYSTEM_TOMLPLUSPLUS=1
	export USE_SYSTEM_UTFCPP=1
	export USE_SYSTEM_VULKAN_HEADERS=1
	export USE_SYSTEM_VULKAN_MEMORY_ALLOCATOR=1
	export USE_SYSTEM_XBYAK=1
	export USE_SYSTEM_XXHASH=1
	export USE_SYSTEM_ZARCHIVE=1
	export USE_SYSTEM_ZLIB_NG=1
	export USE_SYSTEM_ZSTD=1
	export XENIA_BUILD_BRANCH="${PV}"
	export XENIA_BUILD_COMMIT="${SHA}"
	export XENIA_BUILD_COMMIT_SHORT="${SHA:0:7}"
	XENIA_DISCORD="$(usex discord 1 0)"
	export XENIA_DISCORD
	export XENIA_USE_SYSTEM_PREMAKE=1
}

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}"/third_party/{aes_128,binutils-ppc-cygwin} || die
	rm -rf "${S}"/third_party/date || die
	rmdir "${S}"/third_party/{FidelityFX-CAS,FidelityFX-FSR} || die
	rm -rf "${S}"/third_party/disruptorplus || die
	rm -rf "${S}"/third_party/FFmpeg || die
	rm -rf "${S}"/third_party/imgui || die
	rm -rf "${S}"/third_party/glslang || die
	rm -rf "${S}"/third_party/rapidcsv || die
	rm -rf "${S}"/third_party/SPIRV-Tools || die
	rm -rf "${S}"/third_party/tabulate || die
	rmdir "${S}"/third_party/{premake-androidndk,premake-cmake,premake-core} || die
	rmdir "${S}"/third_party/premake-export-compile-commands || die
	mv "${WORKDIR}/aes_128-${AES_128_SHA}" "${S}/third_party/aes_128" || die
	mv "${WORKDIR}/binutils-ppc-cygwin-${BINUTILS_PPC_CYGWIN_SHA}" \
		"${S}/third_party/binutils-ppc-cygwin" || die
	mv "${WORKDIR}/date-${DATE_SHA}" "${S}/third_party/date" || die
	mv "${WORKDIR}/FidelityFX-CAS-${FIDELITYFX_CAS_SHA}" \
		"${S}/third_party/FidelityFX-CAS" || die
	mv "${WORKDIR}/FidelityFX-FSR-${FIDELITYFX_FSR_SHA}" \
		"${S}/third_party/FidelityFX-FSR" || die
	mv "${WORKDIR}/disruptorplus-${DISRUPTORPLUS_SHA}" "${S}/third_party/disruptorplus" || die
	mv "${WORKDIR}/FFmpeg_radixsplit-${FFMPEG_SHA}" "${S}/third_party/FFmpeg" || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" "${S}/third_party/glslang" || die
	mv "${WORKDIR}/rapidcsv-${RAPIDCSV_SHA}" "${S}/third_party/rapidcsv" || die
	mv "${WORKDIR}/SPIRV-Tools-${SPIRV_TOOLS_SHA}" "${S}/third_party/SPIRV-Tools" || die
	mv "${WORKDIR}/tabulate-${TABULATE_SHA}" "${S}/third_party/tabulate" || die
	mv "${WORKDIR}/premake-androidndk-${PREMAKE_ANDROIDNDK_SHA}" \
		"${S}/third_party/premake-androidndk" || die
	mv "${WORKDIR}/premake-cmake-${PREMAKE_CMAKE_SHA}" \
		"${S}/third_party/premake-cmake" || die
	mv "${WORKDIR}/premake-core-${PREMAKE_CORE_SHA}" \
		"${S}/third_party/premake-core" || die
	mv "${WORKDIR}/premake-export-compile-commands-${PREMAKE_EXPORT_CC_SHA}" \
		"${S}/third_party/premake-export-compile-commands" || die
	xenia_env
	default
	premake5 --file=premake5.lua --os=linux --cc=clang --verbose cmake || die
	mkdir -p build || die
	cat <<EOF > build/version.h
#ifndef GENERATED_VERSION_H_
#define GENERATED_VERSION_H_
#define XE_BUILD_BRANCH "${XENIA_BUILD_BRANCH}"
#define XE_BUILD_COMMIT "${XENIA_BUILD_COMMIT}"
#define XE_BUILD_COMMIT_SHORT "${XENIA_BUILD_COMMIT_SHORT}"
#define XE_BUILD_DATE __DATE__
#endif  // GENERATED_VERSION_H_
EOF
	cmake_prepare
}

src_configure() {
	xenia_env
	cmake_src_configure
}

src_install() {
	local build_type=${CMAKE_BUILD_TYPE:-Release}
	newbin "build/bin/Linux/${build_type}/${PN/-/_}" "${PN}"
	for size in 16 32 48 64 128 256 512 1024; do
		newicon -s ${size} "assets/icon/${size}.png" "${PN}.png"
	done
	make_desktop_entry xenia-canary "Xenia Canary" "${PN}" "Game;Emulator"
	dodoc README.md
}
