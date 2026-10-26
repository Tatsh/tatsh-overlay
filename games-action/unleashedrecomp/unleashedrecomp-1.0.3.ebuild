# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic toolchain-funcs xdg

MY_PN="UnleashedRecomp"

# Game files the recompiler translates. They cannot be fetched; see pkg_nofetch.
UR_GAME_FILES=( default.xex default.xexp shader.ar )

# Bundled submodules as "path|owner/repo|commit", parents before their children. The rest come
# from the system (see the patch) or are Windows only.
UR_SUBMODULES=(
	"UnleashedRecomp/api|hedge-dev/SWA|f299dd8cf272a0110c91e54e2b6e308a2d897966"
	"UnleashedRecompResources|hedge-dev/UnleashedRecompResources|35322388006365a648f75f4981a496b12a7f7478"
	"thirdparty/concurrentqueue|cameron314/concurrentqueue|6dd38b8a1dbaa7863aa907045f32308a56a6ff5d"
	"thirdparty/ddspp|redorav/ddspp|98ce1d384706c8d7121876742a786f4eb89a23ef"
	"thirdparty/imgui|ocornut/imgui|8199457a7d9e453f8d3d9cadc14683fb54a858b5"
	"thirdparty/implot|epezent/implot|77674d270e851d3f3718aad00234201af2b76ac9"
	"thirdparty/msdf-atlas-gen|Chlumsky/msdf-atlas-gen|7e8d34645a67c6e4def5d281f7adec1c2501dc49"
	"thirdparty/msdf-atlas-gen/msdfgen|Chlumsky/msdfgen|5a88b0c2b95033f7eee826b27c48d399d544d814"
	"thirdparty/volk|zeux/volk|447e21b5d92ed8d5271b0d39b071f938fcfa875f"
	"tools/XenonRecomp|hedge-dev/XenonRecomp|c017eb630ab917bffd3bc6a0a46995b49e7d8049"
	"tools/XenonRecomp/thirdparty/libmspack|kyz/libmspack|305907723a4e7ab2018e58040059ffb5e77db837"
	"tools/XenonRecomp/thirdparty/tiny-AES-c|kokke/tiny-AES-c|23856752fbd139da0b8ca6e471a13d5bcc99a08d"
	"tools/XenosRecomp|hedge-dev/XenosRecomp|56738e5893ed7c4dc108996590475c52726623e3"
	"tools/XenosRecomp/thirdparty/smol-v|aras-p/smol-v|9dd54c379ac29fa148cb1b829bb939ba7381d8f4"
)

DESCRIPTION="Static recompilation of Sonic Unleashed for Xbox 360"
HOMEPAGE="https://github.com/hedge-dev/UnleashedRecomp"
SRC_URI="fetch+https://github.com/hedge-dev/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
_ur_mod=
for _ur_mod in "${UR_SUBMODULES[@]}"; do
	_ur_repo="${_ur_mod#*|}"
	_ur_repo="${_ur_repo%%|*}"
	_ur_sha="${_ur_mod##*|}"
	SRC_URI+="
	fetch+https://github.com/${_ur_repo}/archive/${_ur_sha}.tar.gz -> ${_ur_repo##*/}-${_ur_sha}.tar.gz"
done
unset _ur_mod _ur_repo _ur_sha
SRC_URI+=" ${UR_GAME_FILES[*]/#/${PN}-}"
S="${WORKDIR}/${MY_PN}-${PV}"

# UnleashedRecomp GPL-3, concurrentqueue BSD-2 or Boost, libmspack LGPL-2.1, smol-v public-domain,
# tiny-AES-c Unlicense, the rest MIT. UnleashedRecompResources has no licence at all.
LICENSE="GPL-3 || ( BSD-2 Boost-1.0 ) LGPL-2.1 MIT Unlicense all-rights-reserved public-domain"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch mirror"

RDEPEND="app-arch/zstd:=
	dev-libs/libfmt:=
	dev-libs/nativefiledialog-extended
	dev-libs/xxhash
	media-libs/freetype:2
	media-libs/libsdl2[vulkan,X]
	media-libs/sdl2-mixer[vorbis]
	media-libs/vulkan-loader
	net-misc/curl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-cpp/magic_enum
	dev-cpp/nlohmann_json
	dev-cpp/tomlplusplus
	dev-libs/stb
	dev-libs/unordered_dense
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator"
# DXC compiles the HLSL shaders and the recompiled game shaders.
BDEPEND="dev-util/DirectXShaderCompiler
	llvm-core/clang
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-system-libs.patch" )

pkg_nofetch() {
	einfo "Unleashed Recompiled translates the game's own code and shaders while it builds, so it"
	einfo "needs three files from your legally acquired copy of Sonic Unleashed for Xbox 360. The"
	einfo "Manifest expects the US retail disc and the title update, which was only released for"
	einfo "Europe but applies to the US game too. Copy them into your DISTDIR as:"
	einfo
	einfo "  ${PN}-default.xex   default.xex from the root of the US disc image"
	einfo "  ${PN}-shader.ar     shader.ar from the root of the US disc image"
	einfo "  ${PN}-default.xexp  default.xexp from title update #2, a file named TU_19KA20I* in"
	einfo "                      /Content/Cache/ on an Xbox 360 that has downloaded it. That file"
	einfo "                      is an STFS container; extract default.xexp with Velocity or"
	einfo "                      another STFS extractor."
	einfo
	einfo "Upstream documents dumping these in docs/DUMPING-en.md."
}

src_unpack() {
	# The game files are copied in src_prepare; only the source archives need unpacking.
	local f
	for f in ${A}; do
		[[ ${f} == *.tar.gz ]] && unpack "${f}"
	done
}

src_prepare() {
	local mod path repo sha
	for mod in "${UR_SUBMODULES[@]}"; do
		path="${mod%%|*}"
		repo="${mod#*|}"
		repo="${repo%%|*}"
		sha="${mod##*|}"
		rm -rf "${path}" || die
		mv "${WORKDIR}/${repo##*/}-${sha}" "${path}" || die
	done
	cmake_src_prepare

	local name
	for name in "${UR_GAME_FILES[@]}"; do
		cp "${DISTDIR}/${PN}-${name}" "UnleashedRecompLib/private/${name}" || die
	done
}

src_configure() {
	# The recompiled code relies on Clang builtins such as __builtin_assume.
	if ! tc-is-clang; then
		export CC="${CHOST}-clang" CXX="${CHOST}-clang++"
		strip-unsupported-flags
		# Clang reads -flto=auto as serial full LTO; ThinLTO is the parallel equivalent.
		replace-flags -flto=auto -flto=thin
	fi
	local mycmakeargs=(
		# Upstream's sources rely on their precompiled headers for includes such as <cstdint>.
		-DCMAKE_DISABLE_PRECOMPILE_HEADERS=OFF
		-Wno-dev
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile "${MY_PN}"
}

src_install() {
	exeinto "/usr/libexec/${PN}"
	doexe "${BUILD_DIR}/${MY_PN}/${MY_PN}"
	newbin "${FILESDIR}/${PN}.sh" "${PN}"
	newicon -s 128 UnleashedRecompResources/images/game_icon.png "${PN}.png"
	make_desktop_entry "${PN}" "Unleashed Recompiled" "${PN}" "Game;ActionGame;"
	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst
	elog "Run ${PN} and point its installer at your copy of Sonic Unleashed. The game is installed"
	elog "to UnleashedRecomp in XDG_DATA_HOME (default .local/share in your home directory), and"
	elog "settings go to .config/UnleashedRecomp in your home directory."
}
