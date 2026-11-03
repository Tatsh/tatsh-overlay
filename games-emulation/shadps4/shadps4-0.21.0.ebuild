# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg

MY_PV="v.${PV}"
FDK_AAC_SHA="ee76460efbdb147e26d804c798949c23f174460b"
HALF_SHA="1ddada225144cac0de8f6b5c0dd9acffd99a2e68"
HWINFO_SHA="8660006e0ca4aae5dda7a29e585968b50b0273b7"
IMGUI_SHA="7e1b65d26d52e9dd199d889c148c72184de647b4"
IMGUIFILEDIALOG_SHA="57a1c6a6d44bd99e844e3642d27851f6c065af62"
LIBATRAC9_SHA="946e05a9212976626a9f5e52f29c0a7202871f29"
MINIMP3_SHA="7b590fdcfa5a79c033e76eacc05d0c3e4c79f536"
QTLAUNCHER_SHA="3d4f8d2ec00b830c6fb5459f2de6213168370c17"
QTLAUNCHER_VERSION="2026.10.17"
SIRIT_SHA="fc2b42d5e57ee2f638676c0c02f7fd71934b596a"
SPDLOG_SHA="b8944a4bcd478ee03375c9c50dc8d6c741f43f7b"
VOLK_SHA="e51c647181c7a8101454e69446079bc34100a320"

DESCRIPTION="PlayStation 4 emulator"
HOMEPAGE="https://shadps4.net/ https://github.com/shadps4-emu/shadPS4"
SRC_URI="https://github.com/shadps4-emu/shadPS4/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/mstorsjo/fdk-aac/archive/${FDK_AAC_SHA}.tar.gz -> ${PN}-fdk-aac-${FDK_AAC_SHA}.tar.gz
	https://github.com/ROCm/half/archive/${HALF_SHA}.tar.gz -> ${PN}-half-${HALF_SHA}.tar.gz
	https://github.com/shadps4-emu/ext-hwinfo/archive/${HWINFO_SHA}.tar.gz -> ${PN}-hwinfo-${HWINFO_SHA}.tar.gz
	https://github.com/shadexternals/imgui/archive/${IMGUI_SHA}.tar.gz -> ${PN}-imgui-${IMGUI_SHA}.tar.gz
	https://github.com/shadexternals/ImGuiFileDialog/archive/${IMGUIFILEDIALOG_SHA}.tar.gz
		-> ${PN}-ImGuiFileDialog-${IMGUIFILEDIALOG_SHA}.tar.gz
	https://github.com/shadps4-emu/ext-LibAtrac9/archive/${LIBATRAC9_SHA}.tar.gz
		-> ${PN}-LibAtrac9-${LIBATRAC9_SHA}.tar.gz
	https://github.com/lieff/minimp3/archive/${MINIMP3_SHA}.tar.gz -> ${PN}-minimp3-${MINIMP3_SHA}.tar.gz
	https://github.com/shadps4-emu/sirit/archive/${SIRIT_SHA}.tar.gz -> ${PN}-sirit-${SIRIT_SHA}.tar.gz
	https://github.com/gabime/spdlog/archive/${SPDLOG_SHA}.tar.gz -> ${PN}-spdlog-${SPDLOG_SHA}.tar.gz
	gui? (
		https://github.com/shadps4-emu/shadps4-qtlauncher/archive/${QTLAUNCHER_SHA}.tar.gz
			-> ${PN}-qtlauncher-${QTLAUNCHER_SHA}.tar.gz
		https://github.com/zeux/volk/archive/${VOLK_SHA}.tar.gz -> ${PN}-volk-${VOLK_SHA}.tar.gz
	)"
S="${WORKDIR}/shadPS4-${MY_PV}"

LICENSE="GPL-2+ BSD Boost-1.0 CC0-1.0 FraunhoferFDK MIT OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui cpu_flags_x86_sse4_1"
REQUIRED_USE="cpu_flags_x86_sse4_1"

RDEPEND="app-arch/zarchive
	>=app-arch/zstd-1.5.6:=
	>=dev-cpp/abseil-cpp-20250512.1:=
	>=dev-libs/boost-1.84:=
	>=dev-libs/libfmt-12:=
	dev-libs/libusb:1
	>=dev-libs/miniz-3.1:=
	dev-libs/openssl:=
	>=dev-libs/protobuf-30:=
	>=dev-libs/pugixml-1.14
	>=dev-libs/xxhash-0.8.2
	dev-libs/zydis:=
	media-libs/freetype
	media-libs/libpng:=
	>=media-libs/libsdl3-3.1.2
	media-libs/openal
	media-libs/vulkan-loader
	media-video/ffmpeg:=
	>=net-libs/miniupnpc-2.3.3:=
	virtual/zlib:=
	gui? (
		dev-qt/qtbase:6[concurrent,gui,network,widgets]
		dev-qt/qtmultimedia:6
	)"
DEPEND="${RDEPEND}
	>=dev-cpp/cli11-2.6.1
	>=dev-cpp/magic_enum-0.9.7
	>=dev-cpp/nlohmann_json-3.12
	dev-cpp/robin-map
	>=dev-cpp/toml11-4.2
	dev-cpp/cpp-httplib
	dev-cpp/tracy
	dev-libs/stb
	>=dev-libs/xbyak-7.07
	dev-util/spirv-headers
	>=dev-util/vulkan-headers-1.4.330
	>=media-libs/VulkanMemoryAllocator-3.1
	dev-util/glslang"
BDEPEND="dev-libs/protobuf
	virtual/pkgconfig
	gui? ( dev-qt/qttools:6[linguist] )"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

src_prepare() {
	local -A ext=(
		[aacdec/fdk-aac]="fdk-aac-${FDK_AAC_SHA}"
		[half]="half-${HALF_SHA}"
		[hwinfo]="ext-hwinfo-${HWINFO_SHA}"
		[imgui]="imgui-${IMGUI_SHA}"
		[ImGuiFileDialog]="ImGuiFileDialog-${IMGUIFILEDIALOG_SHA}"
		[LibAtrac9]="ext-LibAtrac9-${LIBATRAC9_SHA}"
		[minimp3]="minimp3-${MINIMP3_SHA}"
		[sirit]="sirit-${SIRIT_SHA}"
		[spdlog]="spdlog-${SPDLOG_SHA}"
	)
	local d
	for d in "${!ext[@]}"; do
		rmdir "externals/${d}" || die
		mv "${WORKDIR}/${ext[${d}]}" "externals/${d}" || die
	done
	cmake_src_prepare

	if use gui; then
		local launcher="${WORKDIR}/shadps4-qtlauncher-${QTLAUNCHER_SHA}"
		pushd "${launcher}" > /dev/null || die
		rmdir externals/{spdlog,volk} || die
		cp -r "${S}/externals/spdlog" externals/spdlog || die
		mv "${WORKDIR}/volk-${VOLK_SHA}" externals/volk || die
		eapply "${FILESDIR}/${PN}-qtlauncher-system-libs.patch"
		popd > /dev/null || die
		local PATCHES=()
		CMAKE_USE_DIR="${launcher}" BUILD_DIR="${launcher}_build" cmake_src_prepare
	fi
}

src_configure() {
	# The audio code uses SSE4.1 intrinsics; upstream's -march=x86-64-v3 is
	# dropped in favour of the user's flags.
	append-flags -msse4.1
	# Upstream only builds with NDEBUG; without it debug-only code breaks with
	# system fmt 12.
	append-cppflags -DNDEBUG
	local mycmakeargs=(
		-DENABLE_DISCORD_RPC=OFF
		-DENABLE_SYSTEM_LIBRARIES=ON
		-DENABLE_UPDATER=OFF
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
	)
	cmake_src_configure

	if use gui; then
		local launcher="${WORKDIR}/shadps4-qtlauncher-${QTLAUNCHER_SHA}"
		# qt_standard_project_setup() adds an $ORIGIN RPATH meant for relocatable bundles.
		mycmakeargs=(
			-DCMAKE_SKIP_INSTALL_RPATH=ON
			-DENABLE_UPDATER=OFF
			# The tarball has no git metadata for the title bar.
			-DLAUNCHER_APP_VERSION="${QTLAUNCHER_VERSION}"
			-DLAUNCHER_GIT_BRANCH=main
			-DLAUNCHER_GIT_DESC="${QTLAUNCHER_SHA:0:7}"
			# Register the shadps4 found in PATH as the default emulator version.
			-DSHADPS4_SYSTEM_VERSION="${PV}"
		)
		CMAKE_USE_DIR="${launcher}" BUILD_DIR="${launcher}_build" cmake_src_configure
	fi
}

src_compile() {
	cmake_src_compile
	if use gui; then
		BUILD_DIR="${WORKDIR}/shadps4-qtlauncher-${QTLAUNCHER_SHA}_build" cmake_src_compile
	fi
}

src_install() {
	cmake_src_install
	if use gui; then
		BUILD_DIR="${WORKDIR}/shadps4-qtlauncher-${QTLAUNCHER_SHA}_build" cmake_src_install
	fi
}
