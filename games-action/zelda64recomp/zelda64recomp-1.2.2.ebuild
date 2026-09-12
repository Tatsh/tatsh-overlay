# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )

inherit cmake edo flag-o-matic python-any-r1 xdg

MY_PN="Zelda64Recomp"

# The original NTSC-U ROM. Upstream asks for a decompressed image instead, but
# that is something the user would have to produce with a separate tool, so
# take the ROM as it comes and decompress it here with the copy of the Majora's
# Mask decompilation that is already vendored for its headers.
MY_ROM="mm.us.rev1.z64"
MY_ROM_SHA1="d6133ace5afaa0882cf214cf88daba39e266c078"
MY_ROM_UNCOMPRESSED="mm.us.rev1.rom_uncompressed.z64"

# Every git submodule, recursively, as "path|owner/repo|commit". Upstream pins
# each of these to an exact commit and builds them in tree;
# lib/freetype-windows-binaries is left out because it is Windows only.
Z64_SUBMODULES=(
	"Zelda64RecompSyms|Zelda64Recomp/Zelda64RecompSyms|a325f8fa5c48c925616bd43685ef14bbabc29537"
	"lib/N64ModernRuntime|N64Recomp/N64ModernRuntime|df7e820d8c55e4fcb4616c210cbb2c01b25cd48c"
	"lib/RmlUi|mikke89/RmlUi|7a06f27db04fe5d13a5dacc19b2b4544673a4eca"
	"lib/lunasvg|sammycage/lunasvg|4166d0cccfc059b39d5ecfc372524375e59448f9"
	"lib/mm-decomp|zeldaret/mm|5607eec18bae68e4cd38ef6d1fa69d7f1d84bfc8"
	"lib/rt64|rt64/rt64|23cab603c4f9f4a8b369b38e036f1aa484603878"
	"lib/N64ModernRuntime/N64Recomp|N64Recomp/N64Recomp|c1a6dc93bfa5977de0ea256562058be4f1b73353"
	"lib/N64ModernRuntime/thirdparty/miniz|richgel999/miniz|8573fd7cd6f49b262a0ccc447f3c6acfc415e556"
	"lib/N64ModernRuntime/thirdparty/o1heap|N64Recomp/o1heap|a124b850791db2a33f7354d2b0aa7da821cef6f5"
	"lib/N64ModernRuntime/thirdparty/xxHash|Cyan4973/xxHash|ac3a25da3d957d9ef3e4114d9f8332d34ce83a46"
	"lib/N64ModernRuntime/N64Recomp/lib/ELFIO|serge1/ELFIO|ad8b641f9682b6091ba8b9f7c8152255c1a2c803"
	"lib/N64ModernRuntime/N64Recomp/lib/fmt|fmtlib/fmt|8e728044f673774160f43b44a07c6b185352310f"
	"lib/N64ModernRuntime/N64Recomp/lib/rabbitizer|Decompollaborate/rabbitizer|e0d8003047938e2ec3697eaf8d61a84d11d17b43"
	"lib/N64ModernRuntime/N64Recomp/lib/sljit|zherczeg/sljit|f6326087b3404efb07c6d3deed97b3c3b8098c0c"
	"lib/N64ModernRuntime/N64Recomp/lib/tomlplusplus|marzer/tomlplusplus|1f7884e59165e517462f922e7b6de131bd9844f3"
	"lib/rt64/src/contrib/D3D12MemoryAllocator|GPUOpen-LibrariesAndSDKs/D3D12MemoryAllocator|55ad7acfdd69d33fa58150cbc79862fd17e98c0d"
	"lib/rt64/src/contrib/Vulkan-Headers|KhronosGroup/Vulkan-Headers|fc6c06ac529e4b4b6e34c17cc650a8f62dee2eb0"
	"lib/rt64/src/contrib/VulkanMemoryAllocator|GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator|98c4f3414b015432c6b040bdb53b5ba0c5d6c680"
	"lib/rt64/src/contrib/ddspp|redorav/ddspp|2bdf73882b9169ca9d7a307b24d65d6c4e196084"
	"lib/rt64/src/contrib/dxc|rt64/dxc-bin|cc15e715ee378a4f675b335bd1071ff105873fc8"
	"lib/rt64/src/contrib/hlslpp|redorav/hlslpp|6f5274c66132e8f951c400103d897582b8f21491"
	"lib/rt64/src/contrib/im3d|john-chapman/im3d|d03941725fd0bd08c78c46e3e5b0265526e9d060"
	"lib/rt64/src/contrib/imgui|ocornut/imgui|277ae93c41314ba5f4c7444f37c4319cdf07e8cf"
	"lib/rt64/src/contrib/implot|epezent/implot|f156599faefe316f7dd20fe6c783bf87c8bb6fd9"
	"lib/rt64/src/contrib/mupen64plus-core|mupen64plus/mupen64plus-core|860fac3fbae94194a392c1d9857e185eda6d083e"
	"lib/rt64/src/contrib/mupen64plus-win32-deps|mupen64plus/mupen64plus-win32-deps|de8111fdcb89144abc16c85650ce4e21e028bfb5"
	"lib/rt64/src/contrib/nativefiledialog-extended|btzy/nativefiledialog-extended|17b6e8ce219c0677f94b63636abb9296b28841ca"
	"lib/rt64/src/contrib/re-spirv|rt64/re-spirv|5d6b756ee62760f71b65d37e41a0b5a3dab90507"
	"lib/rt64/src/contrib/spirv-cross|KhronosGroup/SPIRV-Cross|6173e24b31f09a0c3217103a130e74c4ddec14a6"
	"lib/rt64/src/contrib/stb|nothings/stb|ae721c50eaf761660b4f90cc590453cdb0c2acd0"
	"lib/rt64/src/contrib/volk|zeux/volk|466085407d5d2f50583fd663c1d65f93a7709d3e"
	"lib/rt64/src/contrib/xxHash|Cyan4973/xxHash|1864a50c9b5cf8500d8e9e61ed92aa0dd3772750"
	"lib/rt64/src/contrib/zstd|facebook/zstd|0ff651dd876823b99fa5c5f53292be28381aee9b"
	"lib/rt64/src/contrib/re-spirv/external/SPIRV-Headers|KhronosGroup/SPIRV-Headers|f013f08e4455bcc1f0eed8e3dd5e2009682656d9"
)

DESCRIPTION="Static recompilation of The Legend of Zelda: Majora's Mask."
HOMEPAGE="https://github.com/Zelda64Recomp/Zelda64Recomp"
SRC_URI="https://github.com/Zelda64Recomp/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

_z64_mod=
for _z64_mod in "${Z64_SUBMODULES[@]}"; do
	_z64_repo="${_z64_mod#*|}"
	_z64_repo="${_z64_repo%%|*}"
	_z64_sha="${_z64_mod##*|}"
	SRC_URI+="
	https://github.com/${_z64_repo}/archive/${_z64_sha}.tar.gz
	-> ${_z64_repo##*/}-${_z64_sha}.tar.gz"
done
unset _z64_mod _z64_repo _z64_sha

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
# Does not link: see the comment above src_configure. Keyword this once the
# duplicate symbols between RecompiledFuncs and PatchesLib are resolved.
#KEYWORDS="~amd64"
RESTRICT="bindist mirror"

RDEPEND="
	media-libs/freetype:2
	media-libs/libglvnd
	media-libs/libsdl2
	x11-libs/libX11
"
DEPEND="${RDEPEND}"
# shellcheck disable=SC2016
BDEPEND="
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/libyaz0[${PYTHON_USEDEP}]')
	dev-util/vulkan-headers
"

PATCHES=( "${FILESDIR}/${P}-n64recomp-section-bounds.patch" )

python_check_deps() {
	python_has_version "dev-python/libyaz0[${PYTHON_USEDEP}]"
}

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	# The ROM is not a distfile: it cannot be distributed, and a package wide
	# RESTRICT="fetch" would stop Portage fetching the submodule archives too.
	# Check it by hand instead.
	if [[ ! -f ${DISTDIR}/${MY_ROM} ]]; then
		eerror "Place your unmodified NTSC-U ROM in ${DISTDIR} as ${MY_ROM}."
		die "${MY_ROM} not found"
	fi
	local got
	got=$(sha1sum "${DISTDIR}/${MY_ROM}") || die
	if [[ ${got%% *} != "${MY_ROM_SHA1}" ]]; then
		eerror "${MY_ROM} has sha1 ${got%% *}, expected ${MY_ROM_SHA1}."
		die "${MY_ROM} is not the expected ROM"
	fi

	local mod path repo sha
	for mod in "${Z64_SUBMODULES[@]}"; do
		path="${mod%%|*}"
		repo="${mod#*|}"
		repo="${repo%%|*}"
		sha="${mod##*|}"
		rm -rf "${path}" || die
		# Only for nested submodules: with no slash this expansion returns
		# the path itself, which would create the destination and move into it.
		if [[ ${path} == */* ]]; then
			mkdir -p "${path%/*}" || die
		fi
		mv "${WORKDIR}/${repo##*/}-${sha}" "${path}" || die
	done

	# The recompiler wants a decompressed image, which upstream expects the
	# user to have produced beforehand. fixbaserom.py out of the vendored
	# decompilation does exactly that, and insists on its own input name.
	cp "${DISTDIR}/${MY_ROM}" baserom.mm.us.rev1.z64 || die
	edo "${EPYTHON}" lib/mm-decomp/tools/fixbaserom.py
	[[ -s baserom_uncompressed.z64 ]] ||
		die "fixbaserom.py produced no decompressed ROM"
	mv baserom_uncompressed.z64 "${MY_ROM_UNCOMPRESSED}" || die
	rm -f baserom.mm.us.rev1.z64 || die

	# The game patches are cross compiled for MIPS and pass an Actor * where
	# an EnTest7 * is expected, which clang 16 rejects rather than warns about.
	sed -i -e 's|-Wno-incompatible-library-redeclaration|& -Wno-error=incompatible-pointer-types|' \
		patches/Makefile || die
	grep -q 'Wno-error=incompatible-pointer-types' patches/Makefile ||
		die "failed to relax the patch build warnings"

	# RmlUi's bundled robin_hood.h uses the fixed-width integer types without
	# including <cstdint>, which GCC 16 no longer provides transitively.
	local hh="lib/RmlUi/Include/RmlUi/Core/Containers/robin_hood.h"
	grep -q '#include <cstdint>' "${hh}" ||
		sed -i -e '0,/^#include </s//#include <cstdint>\n#include </' "${hh}" || die
	grep -q '#include <cstdint>' "${hh}" || die "failed to patch ${hh}"

	cmake_src_prepare
}

src_configure() {
	filter-lto

	# Zelda64Recomp braces a float into a uint8_t colour component.
	append-cxxflags -Wno-narrowing

	# The recompiler has to be built and run before the main configure rather
	# than in src_compile: CMakeLists.txt globs its output into the
	# RecompiledFuncs target, so the generated sources have to exist by the
	# time CMake runs.
	#
	# This currently produces a RecompiledFuncs that duplicates every function
	# PatchesLib also defines, so the final link fails. Upstream's CI builds
	# N64Recomp from a separate checkout pinned to a workflow input rather than
	# from this submodule, and also unpacks a private archive before building,
	# so the revision that produces matching output is not known from the
	# released sources.
	#
	# N64Recomp records functions whose ELF symbol has no real section, then
	# indexes the section list with that index anyway. GCC on Gentoo defines
	# _GLIBCXX_ASSERTIONS by default, which turns those reads into aborts.
	# This is a build time code generator rather than anything that ships, and
	# upstream builds and tests it without the assertions, so match that here;
	# the shipped binary is still built with Gentoo's defaults.
	edo cmake -S lib/N64ModernRuntime/N64Recomp -B "${WORKDIR}/recomp-build" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_CXX_FLAGS="-U_GLIBCXX_ASSERTIONS"
	edo cmake --build "${WORKDIR}/recomp-build" --target N64RecompCLI RSPRecomp

	# The build also invokes ./N64Recomp itself, for the patches, so the
	# tools have to sit in the source root the way BUILDING.md describes.
	cp "${WORKDIR}/recomp-build/N64Recomp" \
		"${WORKDIR}/recomp-build/RSPRecomp" . || die

	edo ./N64Recomp us.rev1.toml
	edo ./RSPRecomp aspMain.us.rev1.toml
	edo ./RSPRecomp njpgdspMain.us.rev1.toml

	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/Zelda64Recompiled" "${PN}"

	insinto "/usr/share/${PN}"
	doins -r assets/.

	einstalldocs
}

pkg_postinst() {
	elog "Run ${PN} and point it at a standard, compressed NTSC-U Majora's"
	elog "Mask ROM. Its own assets are installed in /usr/share/${PN}."
}
