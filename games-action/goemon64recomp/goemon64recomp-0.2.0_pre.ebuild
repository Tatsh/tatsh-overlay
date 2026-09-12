# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )

inherit cmake edo flag-o-matic python-any-r1 xdg

MY_PN="Goemon64Recomp"
# Upstream tags this v0.2.0-dev, which is not a valid version suffix here.
MY_PV="0.2.0-dev"

# The original NTSC-U ROM.
MY_ROM="mnsg.us.z64"
MY_ROM_SHA1="df8083a54296b8c151917c5333e1c85f014a2a66"
MY_ROM_DECOMPRESSED="mnsg.us.decompressed.z64"

# Every git submodule, recursively, as "path|owner/repo|commit". Upstream pins
# each of these to an exact commit and builds them in tree;
# lib/freetype-windows-binaries is left out because it is Windows only.
G64_SUBMODULES=(
	"Goemon64RecompSyms|klorfmorf/Goemon64RecompSyms|49f4e3269f05c737cb4bf698b9ef7142c92f1ac7"
	"lib/N64ModernRuntime|klorfmorf/N64ModernRuntime|fc4592a31414daf0040c19907e0b1976b2e48a67"
	"lib/RmlUi|mikke89/RmlUi|7a06f27db04fe5d13a5dacc19b2b4544673a4eca"
	"lib/lunasvg|sammycage/lunasvg|4166d0cccfc059b39d5ecfc372524375e59448f9"
	"lib/mnsg|klorfmorf/mnsg|be85f9018b1fb2ffa332270d6abfb9f8c3cae323"
	"lib/rt64|klorfmorf/rt64|abb3d7ad0ed60a8a74aa839222d4c107e828b7f5"
	"lib/N64ModernRuntime/N64Recomp|N64Recomp/N64Recomp|07fcdac76da3e47105238d45defe83d56c2821f5"
	"lib/N64ModernRuntime/thirdparty/miniz|richgel999/miniz|8573fd7cd6f49b262a0ccc447f3c6acfc415e556"
	"lib/N64ModernRuntime/thirdparty/o1heap|N64Recomp/o1heap|a124b850791db2a33f7354d2b0aa7da821cef6f5"
	"lib/N64ModernRuntime/thirdparty/xxHash|Cyan4973/xxHash|ac3a25da3d957d9ef3e4114d9f8332d34ce83a46"
	"lib/mnsg/tools/asm-differ|simonlindholm/asm-differ|4eb23bcd4bbeab81c16535c6318389e0c55584f7"
	"lib/mnsg/tools/decomp-permuter|simonlindholm/decomp-permuter|ec2efeebb33e2b1de81e39fbf7cbe3cd97350472"
	"lib/mnsg/tools/m2c|matt-kempster/m2c|a21c1dcd7255b176c032bb932f521846e98d4372"
	"lib/N64ModernRuntime/N64Recomp/lib/ELFIO|serge1/ELFIO|ad8b641f9682b6091ba8b9f7c8152255c1a2c803"
	"lib/N64ModernRuntime/N64Recomp/lib/fmt|fmtlib/fmt|0e8aad961d66904cfda8d7cc894f6f6eee2d9f30"
	"lib/N64ModernRuntime/N64Recomp/lib/rabbitizer|Decompollaborate/rabbitizer|e0d8003047938e2ec3697eaf8d61a84d11d17b43"
	"lib/N64ModernRuntime/N64Recomp/lib/sljit|zherczeg/sljit|f6326087b3404efb07c6d3deed97b3c3b8098c0c"
	"lib/N64ModernRuntime/N64Recomp/lib/tomlplusplus|marzer/tomlplusplus|1f7884e59165e517462f922e7b6de131bd9844f3"
	"lib/rt64/src/contrib/ddspp|redorav/ddspp|2bdf73882b9169ca9d7a307b24d65d6c4e196084"
	"lib/rt64/src/contrib/dxc|rt64/dxc-bin|cc15e715ee378a4f675b335bd1071ff105873fc8"
	"lib/rt64/src/contrib/hlslpp|redorav/hlslpp|6f5274c66132e8f951c400103d897582b8f21491"
	"lib/rt64/src/contrib/im3d|john-chapman/im3d|d03941725fd0bd08c78c46e3e5b0265526e9d060"
	"lib/rt64/src/contrib/imgui|ocornut/imgui|277ae93c41314ba5f4c7444f37c4319cdf07e8cf"
	"lib/rt64/src/contrib/implot|epezent/implot|f156599faefe316f7dd20fe6c783bf87c8bb6fd9"
	"lib/rt64/src/contrib/mupen64plus-core|mupen64plus/mupen64plus-core|860fac3fbae94194a392c1d9857e185eda6d083e"
	"lib/rt64/src/contrib/mupen64plus-win32-deps|mupen64plus/mupen64plus-win32-deps|de8111fdcb89144abc16c85650ce4e21e028bfb5"
	"lib/rt64/src/contrib/nativefiledialog-extended|btzy/nativefiledialog-extended|17b6e8ce219c0677f94b63636abb9296b28841ca"
	"lib/rt64/src/contrib/plume|renderbag/plume|51b1ad443b9f202c5cfc930ae25345d3f2ba7716"
	"lib/rt64/src/contrib/re-spirv|rt64/re-spirv|5d6b756ee62760f71b65d37e41a0b5a3dab90507"
	"lib/rt64/src/contrib/spirv-cross|KhronosGroup/SPIRV-Cross|6173e24b31f09a0c3217103a130e74c4ddec14a6"
	"lib/rt64/src/contrib/stb|nothings/stb|ae721c50eaf761660b4f90cc590453cdb0c2acd0"
	"lib/rt64/src/contrib/xxHash|Cyan4973/xxHash|1864a50c9b5cf8500d8e9e61ed92aa0dd3772750"
	"lib/rt64/src/contrib/zstd|facebook/zstd|0ff651dd876823b99fa5c5f53292be28381aee9b"
	"lib/rt64/src/contrib/plume/contrib/D3D12MemoryAllocator|GPUOpen-LibrariesAndSDKs/D3D12MemoryAllocator|9ef66bc14edd10dee0de3a545b98578363552f66"
	"lib/rt64/src/contrib/plume/contrib/Vulkan-Headers|KhronosGroup/Vulkan-Headers|2fa203425eb4af9dfc6b03f97ef72b0b5bcb8350"
	"lib/rt64/src/contrib/plume/contrib/VulkanMemoryAllocator|GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator|29b35ea4232688c0f42cdff0c10848290760a417"
	"lib/rt64/src/contrib/plume/contrib/volk|zeux/volk|be3dbd49bf77052665e96b6c7484af855e7e5f67"
	"lib/rt64/src/contrib/re-spirv/external/SPIRV-Headers|KhronosGroup/SPIRV-Headers|f013f08e4455bcc1f0eed8e3dd5e2009682656d9"
)

DESCRIPTION="Static recompilation of Mystical Ninja Starring Goemon."
HOMEPAGE="https://github.com/klorfmorf/Goemon64Recomp"
SRC_URI="https://github.com/klorfmorf/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz
	-> ${P}.tar.gz"

_g64_mod=
for _g64_mod in "${G64_SUBMODULES[@]}"; do
	_g64_repo="${_g64_mod#*|}"
	_g64_repo="${_g64_repo%%|*}"
	_g64_sha="${_g64_mod##*|}"
	SRC_URI+="
	https://github.com/${_g64_repo}/archive/${_g64_sha}.tar.gz
	-> ${_g64_repo##*/}-${_g64_sha}.tar.gz"
done
unset _g64_mod _g64_repo _g64_sha

S="${WORKDIR}/${MY_PN}-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
# Not installable yet: the ROM cannot be decompressed here, and the recompiler
# has the same problem as games-action/zelda64recomp. See src_prepare and
# src_configure. Keyword this once both are resolved.
#KEYWORDS="~amd64"
# The ROM cannot be distributed and has to be supplied by the user.
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
	$(python_gen_any_dep 'dev-python/pyyaml[${PYTHON_USEDEP}]')
	dev-util/vulkan-headers
"

python_check_deps() {
	python_has_version "dev-python/pyyaml[${PYTHON_USEDEP}]"
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
	for mod in "${G64_SUBMODULES[@]}"; do
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

	# The recompiler reads a decompressed image. The vendored decompilation
	# ships the tool that produces it, tools/rommy.py, but not the manifest it
	# needs: lib/mnsg/config/usa/rommy.yaml is absent at the commit this pins,
	# so the ROM cannot be decompressed here yet.
	if [[ ! -f lib/mnsg/config/usa/rommy.yaml ]]; then
		die "lib/mnsg has no config/usa/rommy.yaml, so ${MY_ROM} cannot be decompressed"
	fi
	cp "${DISTDIR}/${MY_ROM}" lib/mnsg/config/usa/baserom.z64 || die
	edo "${EPYTHON}" lib/mnsg/tools/rommy.py decompress \
		--input lib/mnsg/config/usa/baserom.z64 \
		--output "${MY_ROM_DECOMPRESSED}" \
		--manifest lib/mnsg/config/usa/rommy.yaml --pad

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

	# The recompiler has to be built and run before the main configure rather
	# than in src_compile: CMakeLists.txt globs its output into the
	# RecompiledFuncs target, so the generated sources have to exist by the
	# time CMake runs.
	#
	# N64Recomp records functions whose ELF symbol has no real section, then
	# indexes the section list with that index anyway. GCC on Gentoo defines
	# _GLIBCXX_ASSERTIONS by default, which turns those reads into aborts, so
	# build this generator without them, the way upstream builds it. Note that
	# games-action/zelda64recomp, which shares this recompiler, then fails to
	# link because the generated functions collide with the patches; expect
	# the same here.
	edo cmake -S lib/N64ModernRuntime/N64Recomp -B "${WORKDIR}/recomp-build" \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_CXX_FLAGS="-U_GLIBCXX_ASSERTIONS"
	edo cmake --build "${WORKDIR}/recomp-build" --target N64RecompCLI RSPRecomp

	# The build also invokes ./N64Recomp itself, for the patches, so the tools
	# have to sit in the source root the way BUILDING.md describes.
	cp "${WORKDIR}/recomp-build/N64Recomp" \
		"${WORKDIR}/recomp-build/RSPRecomp" . || die

	edo ./N64Recomp mnsg.toml
	edo ./RSPRecomp aspMain.toml

	cmake_src_configure
}

src_install() {
	newbin "${BUILD_DIR}/Goemon64Recompiled" "${PN}"

	insinto "/usr/share/${PN}"
	doins -r assets/.

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "Run ${PN} and point it at a standard, compressed NTSC-U Mystical"
	elog "Ninja Starring Goemon ROM. Its own assets are installed in"
	elog "/usr/share/${PN}."
}
