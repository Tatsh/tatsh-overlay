# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic toolchain-funcs

DESCRIPTION="Xbox 360 emulator research project (Canary version)."
HOMEPAGE="https://github.com/xenia-canary/xenia-canary https://xenia.jp/"
SHA="2771366b8bb92d32d475b18a4fe9241c5aa691a4"
AES_128_SHA="7e3ac3bb6b478187472b4ac6f1698eb203e8e90b"
FIDELITYFX_CAS_SHA="9fabcc9a2c45f958aff55ddfda337e74ef894b7f"
FIDELITYFX_FSR_SHA="a21ffb8f6c13233ba336352bdff293894c706575"
DISRUPTORPLUS_SHA="bf9c70c0cc92b6435f7edec75e12751ea37e5c2f"
FFMPEG_SHA="d980192e175e6ff95bcd287af77e16fcb6597974"
GLSLANG_SHA="a57276bf558f5cf94d3a9854ebdf5a2236849a5a"
IMGUI_SHA="4806a1924ff6181180bf5e4b8b79ab4394118875"
RAPIDCSV_SHA="a98b85e663114b8fdc9c0dc03abf22c296f38241"
TABULATE_SHA="3a58301067bbc03da89ae5a51b3e05b7da719d38"
XBYAK_SHA="4e44f4614ddbf038f2a6296f5b906d5c72691e0f"
SRC_URI="https://github.com/xenia-canary/xenia-canary/archive/${SHA}.tar.gz
		-> ${P}-${SHA:0:7}.tar.gz
	https://github.com/openluopworld/aes_128/archive/${AES_128_SHA}.tar.gz
		-> ${PN}-aes_128-${AES_128_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-CAS/archive/${FIDELITYFX_CAS_SHA}.tar.gz
		-> ${PN}-FidelityFX-CAS-${FIDELITYFX_CAS_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-FSR/archive/${FIDELITYFX_FSR_SHA}.tar.gz
		-> ${PN}-FidelityFX-FSR-${FIDELITYFX_FSR_SHA:0:7}.tar.gz
	https://github.com/xenia-canary/disruptorplus/archive/${DISRUPTORPLUS_SHA}.tar.gz
		-> ${PN}-disruptorplus-${DISRUPTORPLUS_SHA:0:7}.tar.gz
	https://github.com/has207/FFmpeg/archive/${FFMPEG_SHA}.tar.gz
		-> ${PN}-FFmpeg-${FFMPEG_SHA:0:7}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/${GLSLANG_SHA}.tar.gz
		-> ${PN}-glslang-${GLSLANG_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz
		-> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/d99kris/rapidcsv/archive/${RAPIDCSV_SHA}.tar.gz
		-> ${PN}-rapidcsv-${RAPIDCSV_SHA:0:7}.tar.gz
	https://github.com/p-ranav/tabulate/archive/${TABULATE_SHA}.tar.gz
		-> ${PN}-tabulate-${TABULATE_SHA:0:7}.tar.gz
	https://github.com/herumi/xbyak/archive/${XBYAK_SHA}.tar.gz
		-> ${PN}-xbyak-${XBYAK_SHA:0:7}.tar.gz"
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
	dev-libs/date
	dev-libs/expat
	dev-libs/libfmt:=
	dev-libs/libpcre2
	dev-libs/pugixml
	dev-libs/xxhash
	dev-util/spirv-tools
	discord? ( dev-libs/discord-rpc )
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/libjpeg-turbo:=
	media-libs/libpulse
	media-libs/libsdl2
	media-libs/libsndfile
	media-libs/VulkanMemoryAllocator
	media-libs/vulkan-loader
	media-video/pipewire
	sys-apps/util-linux
	sys-libs/zlib-ng
	x11-libs/gtk+"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/cxxopts
	dev-libs/utfcpp
	dev-util/vulkan-headers"

PATCHES=(
	"${FILESDIR}/${PN}-0001-fix-build-with-gcc-clang-unc.patch"
	"${FILESDIR}/${PN}-0002-write-xenia.log-to-xdg-state.patch"
	"${FILESDIR}/${PN}-0003-cmake-add-use_system_-de-ven.patch"
	"${FILESDIR}/${PN}-0004-add-use_system_xxhash-option.patch"
	"${FILESDIR}/${PN}-0005-add-use_system_fmt-option-fo.patch"
	"${FILESDIR}/${PN}-0006-add-use_system_zstd-and-use_.patch"
	"${FILESDIR}/${PN}-0007-use-system-glslang-use_syste.patch"
	"${FILESDIR}/${PN}-0008-add-use_system_capstone-opti.patch"
	"${FILESDIR}/${PN}-0009-add-use_system_snappy-option.patch"
	"${FILESDIR}/${PN}-0010-add-use_system_pugixml-optio.patch"
	"${FILESDIR}/${PN}-0011-add-use_system_zlib_ng-optio.patch"
	"${FILESDIR}/${PN}-0012-add-use_system_cxxopts-optio.patch"
	"${FILESDIR}/${PN}-0013-add-use_system_xbyak-option-.patch"
	"${FILESDIR}/${PN}-0014-add-use_system_tomlplusplus-.patch"
	"${FILESDIR}/${PN}-0015-use-system-utfcpp-use_system.patch"
	"${FILESDIR}/${PN}-0016-add-use_system_vulkan_header.patch"
	"${FILESDIR}/${PN}-0017-add-use_system_discord_rpc-o.patch"
	"${FILESDIR}/${PN}-0018-make-discord-rich-presence-o.patch"
	"${FILESDIR}/${PN}-0019-add-use_system_imgui-option-.patch"
	"${FILESDIR}/${PN}-0020-zarchive-sha-256-guard-syste.patch"
	"${FILESDIR}/${PN}-0021-system-date-library-support.patch"
	"${FILESDIR}/${PN}-0022-use-system-sdl2-on-linux.patch"
	"${FILESDIR}/${PN}-0023-add-use_system_spirv_tools-o.patch"
)

# Avoid the upstream Release configuration (forced thin LTO + lld, Clang only).
CMAKE_BUILD_TYPE="RelWithDebInfo"

src_prepare() {
	rm .gitmodules || die
	# Replace the submodule placeholders that are still built from source with
	# the matching upstream-pinned snapshots. Everything else is de-vendored to
	# system libraries.
	rm -rf "${S}"/third_party/{aes_128,disruptorplus,FFmpeg,glslang,imgui,rapidcsv,tabulate,xbyak} || die
	rm -rf "${S}"/third_party/{FidelityFX-CAS,FidelityFX-FSR} || die
	mv "${WORKDIR}/aes_128-${AES_128_SHA}" "${S}/third_party/aes_128" || die
	mv "${WORKDIR}/FidelityFX-CAS-${FIDELITYFX_CAS_SHA}" \
		"${S}/third_party/FidelityFX-CAS" || die
	mv "${WORKDIR}/FidelityFX-FSR-${FIDELITYFX_FSR_SHA}" \
		"${S}/third_party/FidelityFX-FSR" || die
	mv "${WORKDIR}/disruptorplus-${DISRUPTORPLUS_SHA}" \
		"${S}/third_party/disruptorplus" || die
	mv "${WORKDIR}/FFmpeg-${FFMPEG_SHA}" "${S}/third_party/FFmpeg" || die
	mv "${WORKDIR}/glslang-${GLSLANG_SHA}" "${S}/third_party/glslang" || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" "${S}/third_party/imgui" || die
	mv "${WORKDIR}/rapidcsv-${RAPIDCSV_SHA}" "${S}/third_party/rapidcsv" || die
	mv "${WORKDIR}/tabulate-${TABULATE_SHA}" "${S}/third_party/tabulate" || die
	mv "${WORKDIR}/xbyak-${XBYAK_SHA}" "${S}/third_party/xbyak" || die

	# version.h is normally written by xenia-build.py; generate it directly.
	# ${S} is on the include path, so #include "version.h" resolves here.
	cat <<-EOF > "${S}/version.h" || die
		#ifndef GENERATED_VERSION_H_
		#define GENERATED_VERSION_H_
		#define XE_BUILD_BRANCH "${PV}"
		#define XE_BUILD_COMMIT "${SHA}"
		#define XE_BUILD_COMMIT_SHORT "${SHA:0:7}"
		#define XE_BUILD_DATE __DATE__
		#endif  // GENERATED_VERSION_H_
	EOF

	cmake_src_prepare
}

src_configure() {
	if tc-is-gcc; then
		# Causes startup error in libstdc++ HashTable with GCC.
		filter-lto
	fi
	if tc-is-clang; then
		# These flags result in the emulator showing no video (Rocket/Tiger Lake).
		filter-flags -march=* -mtune=*
	fi
	local mycmakeargs=(
		-DXENIA_BUILD_TESTS=OFF
		"-DXENIA_BUILD_DISCORD=$(usex discord ON OFF)"
		-DUSE_SYSTEM_CAPSTONE=ON
		-DUSE_SYSTEM_CXXOPTS=ON
		-DUSE_SYSTEM_DATE=ON
		"-DUSE_SYSTEM_DISCORD_RPC=$(usex discord ON OFF)"
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_PUGIXML=ON
		-DUSE_SYSTEM_SNAPPY=ON
		-DUSE_SYSTEM_SPIRV_TOOLS=ON
		-DUSE_SYSTEM_TOMLPLUSPLUS=ON
		-DUSE_SYSTEM_UTFCPP=ON
		-DUSE_SYSTEM_VULKAN_HEADERS=ON
		-DUSE_SYSTEM_VULKAN_MEMORY_ALLOCATOR=ON
		-DUSE_SYSTEM_XXHASH=ON
		-DUSE_SYSTEM_ZARCHIVE=ON
		-DUSE_SYSTEM_ZLIB_NG=ON
		-DUSE_SYSTEM_ZSTD=ON
	)
	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/bin/Linux/${PN/-/_}" "${PN}"
	for size in 16 32 48 64 128 256 512 1024; do
		newicon -s ${size} "assets/icon/${size}.png" "${PN}.png"
	done
	make_desktop_entry xenia-canary "Xenia Canary" "${PN}" "Game;Emulator"
	dodoc README.md
}
