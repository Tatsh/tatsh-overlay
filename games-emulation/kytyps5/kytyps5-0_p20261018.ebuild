# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {22..23} )

inherit cmake flag-o-matic llvm-r2

MY_TAG="KytyPS5-2026-10-18-37df7f3"
IMGUI_SHA="f1cc2ae15e53a861a874c3034aae6798fde194ab"
LIBATRAC9_SHA="ec8899dadf393f655f2871a94e0fe4b3d6220c9a"
ZARCHIVE_SHA="d2c717730092c7bf8cbb033b12fd4001b7c4d932"

DESCRIPTION="PlayStation 5 translation layer based on Kyty"
HOMEPAGE="https://kytyps5.github.io/ https://github.com/KytyPS5/KytyPS5"
SRC_URI="https://github.com/KytyPS5/KytyPS5/archive/refs/tags/${MY_TAG}.tar.gz -> ${P}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA}.tar.gz
	https://github.com/shadps4-emu/ext-LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz
		-> ${PN}-LibAtrac9-${LIBATRAC9_SHA}.tar.gz
	https://github.com/Exzap/ZArchive/archive/${ZARCHIVE_SHA}.tar.gz -> ${PN}-ZArchive-${ZARCHIVE_SHA}.tar.gz"
S="${WORKDIR}/KytyPS5-${MY_TAG}"

LICENSE="GPL-2 MIT MIT-0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-arch/zstd:=
	>=dev-cpp/tracy-0.14.1-r1
	dev-libs/cpuinfo
	dev-libs/libfmt:=
	dev-libs/spdlog:=
	dev-libs/xxhash
	dev-libs/zydis:=
	dev-qt/qtbase:6[concurrent,dbus,gui,network,widgets]
	dev-util/spirv-tools
	media-libs/libsdl3
	media-libs/opus
	media-libs/vulkan-loader
	media-video/ffmpeg:="
DEPEND="${RDEPEND}
	dev-cpp/magic_enum
	dev-cpp/nlohmann_json
	dev-libs/xbyak
	dev-util/spirv-headers
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator"
# shellcheck disable=SC2016
BDEPEND="dev-util/glslang
	virtual/pkgconfig
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}
		llvm-core/lld:${LLVM_SLOT}
	')"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

src_prepare() {
	rmdir 3rdparty/{imgui,LibAtrac9} || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" 3rdparty/imgui || die
	mv "${WORKDIR}/ext-LibAtrac9-${LIBATRAC9_SHA}" 3rdparty/LibAtrac9 || die
	# The ZArchive sources are CRLF; KytyPS5's hardening patch is LF.
	pushd "${WORKDIR}/ZArchive-${ZARCHIVE_SHA}" > /dev/null || die
	sed -e 's/\r$//' -i src/zarchivereader.cpp include/zarchive/zarchivecommon.h || die
	eapply "${S}/3rdparty/patches/zarchive-reader.patch"
	popd > /dev/null || die
	sed -e "s|set(KYTY_GIT_VERSION \"unknown\")|set(KYTY_GIT_VERSION \"${MY_TAG}\")|" \
		-e "s|set(KYTY_GIT_HASH \"unknown\")|set(KYTY_GIT_HASH \"${MY_TAG##*-}\")|" \
		-i src/generate_version.cmake || die
	cmake_src_prepare
}

src_configure() {
	# Upstream only builds with Clang and links with lld. Both must come from the
	# same slot so lld can read Clang's LTO bitcode.
	llvm_prepend_path "${LLVM_SLOT}"
	local -x CC="${CHOST}-clang" CXX="${CHOST}-clang++"
	strip-unsupported-flags
	local mycmakeargs=(
		-DCMAKE_C_COMPILER_LAUNCHER=
		-DCMAKE_CXX_COMPILER_LAUNCHER=
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/$(get_libdir)/${PN}"
		-DKYTY_ZARCHIVE_DIR="${WORKDIR}/ZArchive-${ZARCHIVE_SHA}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	dosym -r "/usr/$(get_libdir)/${PN}/kyty_launcher" "/usr/bin/${PN}"
	einstalldocs
}
