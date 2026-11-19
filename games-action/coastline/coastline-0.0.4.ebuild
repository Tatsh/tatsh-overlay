# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic xdg

DESCRIPTION="Reconstructed source of the Nintendo 64 game Top Gear Rally"
HOMEPAGE="https://coastline.readthedocs.org/ https://github.com/Tatsh/coastline"
SRC_URI="https://github.com/Tatsh/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# The vendored zlib 1.0.4 carries the game's changes and is part of the reconstruction.
LICENSE="MIT ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="discord test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/bzip2:=
	dev-libs/libfmt:=
	media-libs/flac:=
	media-libs/libsdl3
	media-libs/meshoptimizer
	media-video/ffmpeg:=
	virtual/zlib:="
DEPEND="${RDEPEND}
	dev-cpp/argparse
	dev-cpp/nlohmann_json"
BDEPEND="dev-util/glslang
	virtual/pkgconfig
	dev-util/spirv-cross"

PATCHES=(
	# A socket path too long for sun_path ended the search for the Discord
	# client instead of skipping to the next candidate.
	"${FILESDIR}/${PN}-discord-long-socket-path.patch"
)

src_prepare() {
	cmake_src_prepare
	# media-libs/flac installs only pkg-config files, and the build looks FLAC
	# up in CMake config mode.
	mkdir -p "${T}/flac-cmake" || die
	cat > "${T}/flac-cmake/FLACConfig.cmake" <<-EOF || die
		find_package(PkgConfig REQUIRED)
		pkg_check_modules(FLAC REQUIRED IMPORTED_TARGET GLOBAL flac)
		add_library(FLAC::FLAC ALIAS PkgConfig::FLAC)
	EOF
}

src_configure() {
	local common=(
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		"-DFLAC_DIR=${T}/flac-cmake"
	) name
	# Every dependency comes from the system; nothing is downloaded.
	for name in ARGPARSE BZIP2 FLAC FMT GLSLANG MESHOPTIMIZER NLOHMANN_JSON SDL3 SPIRV_CROSS ZLIB; do
		common+=( "-DUSE_SYSTEM_${name}=ON" )
	done

	local mycmakeargs=(
		"${common[@]}"
		-DCMAKE_SKIP_INSTALL_RPATH=ON
		-DCOASTLINE_DISCORD="$(usex discord)"
		-DCOASTLINE_VIDEO=ON
		-DTGR_ENABLE_PATCHES=ON
		-DTGR_PLATFORM=sdl
	)
	cmake_src_configure

	if use test; then
		# The tests build the reconstructed code for the host in place of the game.
		# They link with -Wl,--wrap to substitute stubs, which LTO defeats; the
		# game above keeps the flags. They compare floating-point results exactly
		# (FMA contraction under -march=native changes them) and the distances
		# between globals defined next to each other.
		filter-lto
		append-flags -ffp-contract=off -fno-toplevel-reorder
		mycmakeargs=(
			"${common[@]}"
			-DTGR_TESTS=ON
		)
		BUILD_DIR="${WORKDIR}/${P}_test" cmake_src_configure
	fi
}

src_compile() {
	cmake_src_compile
	use test && BUILD_DIR="${WORKDIR}/${P}_test" cmake_src_compile
}

src_test() {
	# The tests are built with AddressSanitizer, and the sandbox preloads its
	# library ahead of the ASan runtime.
	local -x ASAN_OPTIONS="verify_asan_link_order=0${ASAN_OPTIONS:+:${ASAN_OPTIONS}}"
	BUILD_DIR="${WORKDIR}/${P}_test" cmake_src_test
}
