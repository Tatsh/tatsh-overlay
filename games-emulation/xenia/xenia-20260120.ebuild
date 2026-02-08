# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Xbox 360 emulator research project."
HOMEPAGE="https://github.com/xenia-project/xenia https://xenia.jp/"
SHA="c7f61342d7061b8264e4b988b8d2e03351b6e088"
AES_128_SHA="b5b7f559cf4b1acbb506a7a8752bbe4adfdc3274"
BINUTILS_PPC_CYGWIN_SHA="6f3f15db908d339472db7be450f7c58bb71545cc"
CPPTOML_SHA="fededad7169e538ca47e11a9ee9251bc361a9a65"
DIRECTX_HEADERS_SHA="33374754f65baac0500dda6187e371136357246f"
DISCORD_RPC_SHA="eff23a770a07c3574cb48f299736c461c576286b"
FIDELITYFX_CAS_SHA="9fabcc9a2c45f958aff55ddfda337e74ef894b7f"
FIDELITYFX_FSR_SHA="a21ffb8f6c13233ba336352bdff293894c706575"
IMGUI_SHA="81160fee56027226bc80b48e196d0332f5541a8c"
PREMAKE_ANDROIDNDK_SHA="e6132d3f7877f9ad361c634db35b708c41075e3a"
PREMAKE_CMAKE_SHA="91c646f638a6fbff20f0ea90769df8dcf62bc5e4"
PREMAKE_CORE_SHA="fe71eb790c7d085cd3c6a7b71a50167b4da06e69"
PREMAKE_EXPORT_CC_SHA="59e3e55df8dd87eea70556f50d172a17f1c4b6d0"
SRC_URI="https://github.com/xenia-project/xenia/archive/${SHA}.tar.gz -> ${P}-${SHA:0:7}.tar.gz
	https://github.com/openluopworld/aes_128/archive/${AES_128_SHA}.tar.gz
		-> ${PN}-aes_128-${AES_128_SHA:0:7}.tar.gz
	https://github.com/benvanik/binutils-ppc-cygwin/archive/${BINUTILS_PPC_CYGWIN_SHA}.tar.gz
		-> ${PN}-binutils-ppc-cygwin-${BINUTILS_PPC_CYGWIN_SHA:0:7}.tar.gz
	https://github.com/skystrife/cpptoml/archive/${CPPTOML_SHA}.tar.gz
		-> ${PN}-cpptoml-${CPPTOML_SHA:0:7}.tar.gz
	https://github.com/microsoft/DirectX-Headers/archive/${DIRECTX_HEADERS_SHA}.tar.gz
		-> ${PN}-DirectX-Headers-${DIRECTX_HEADERS_SHA:0:7}.tar.gz
	https://github.com/discordapp/discord-rpc/archive/${DISCORD_RPC_SHA}.tar.gz
		-> ${PN}-discord-rpc-${DISCORD_RPC_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-CAS/archive/${FIDELITYFX_CAS_SHA}.tar.gz
		-> ${PN}-FidelityFX-CAS-${FIDELITYFX_CAS_SHA:0:7}.tar.gz
	https://github.com/GPUOpen-Effects/FidelityFX-FSR/archive/${FIDELITYFX_FSR_SHA}.tar.gz
		-> ${PN}-FidelityFX-FSR-${FIDELITYFX_FSR_SHA:0:7}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_SHA}.tar.gz
		-> ${PN}-imgui-${IMGUI_SHA:0:7}.tar.gz
	https://github.com/Triang3l/premake-androidndk/archive/${PREMAKE_ANDROIDNDK_SHA}.tar.gz
		-> ${PN}-premake-androidndk-${PREMAKE_ANDROIDNDK_SHA:0:7}.tar.gz
	https://github.com/JoelLinn/premake-cmake/archive/${PREMAKE_CMAKE_SHA}.tar.gz
		-> ${PN}-premake-cmake-${PREMAKE_CMAKE_SHA:0:7}.tar.gz
	https://github.com/xenia-project/premake-core/archive/${PREMAKE_CORE_SHA}.tar.gz
		-> ${PN}-premake-core-${PREMAKE_CORE_SHA:0:7}.tar.gz
	https://github.com/xenia-project/premake-export-compile-commands/archive/${PREMAKE_EXPORT_CC_SHA}.tar.gz
		-> ${PN}-premake-export-compile-commands-${PREMAKE_EXPORT_CC_SHA:0:7}.tar.gz"
S="${WORKDIR}/xenia-${SHA}"

LICENSE="MIT"
SLOT="0"
# KEYWORDS="~amd64"
IUSE="discord"

DEPEND="app-arch/snappy
	dev-cpp/catch:0
	dev-libs/capstone
	dev-libs/cxxopts
	dev-libs/date
	dev-libs/disruptorplus
	dev-libs/libfmt:=
	dev-libs/rapidjson
	dev-libs/utfcpp
	dev-libs/xbyak
	dev-libs/xxhash
	dev-util/DirectXShaderCompiler
	dev-util/vulkan-headers
	media-libs/VulkanMemoryAllocator
	media-libs/libsdl2
	media-video/ffmpeg:=
	virtual/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	rm .gitmodules || die
	rmdir "${S}"/third_party/{aes_128,binutils-ppc-cygwin,cpptoml,DirectX-Headers,discord-rpc} || die
	rmdir "${S}"/third_party/{FidelityFX-CAS,FidelityFX-FSR,imgui} || die
	rmdir "${S}"/third_party/{premake-androidndk,premake-cmake,premake-core} || die
	rmdir "${S}"/third_party/premake-export-compile-commands || die
	mv "${WORKDIR}/aes_128-${AES_128_SHA}" "${S}/third_party/aes_128" || die
	mv "${WORKDIR}/binutils-ppc-cygwin-${BINUTILS_PPC_CYGWIN_SHA}" \
		"${S}/third_party/binutils-ppc-cygwin" || die
	mv "${WORKDIR}/cpptoml-${CPPTOML_SHA}" "${S}/third_party/cpptoml" || die
	mv "${WORKDIR}/DirectX-Headers-${DIRECTX_HEADERS_SHA}" \
		"${S}/third_party/DirectX-Headers" || die
	mv "${WORKDIR}/discord-rpc-${DISCORD_RPC_SHA}" "${S}/third_party/discord-rpc" || die
	mv "${WORKDIR}/FidelityFX-CAS-${FIDELITYFX_CAS_SHA}" \
		"${S}/third_party/FidelityFX-CAS" || die
	mv "${WORKDIR}/FidelityFX-FSR-${FIDELITYFX_FSR_SHA}" \
		"${S}/third_party/FidelityFX-FSR" || die
	mv "${WORKDIR}/imgui-${IMGUI_SHA}" "${S}/third_party/imgui" || die
	mv "${WORKDIR}/premake-androidndk-${PREMAKE_ANDROIDNDK_SHA}" \
		"${S}/third_party/premake-androidndk" || die
	mv "${WORKDIR}/premake-cmake-${PREMAKE_CMAKE_SHA}" \
		"${S}/third_party/premake-cmake" || die
	mv "${WORKDIR}/premake-core-${PREMAKE_CORE_SHA}" \
		"${S}/third_party/premake-core" || die
	mv "${WORKDIR}/premake-export-compile-commands-${PREMAKE_EXPORT_CC_SHA}" \
		"${S}/third_party/premake-export-compile-commands" || die
	default
}

src_configure() {
	emake -C "${S}/third_party/premake-core" -f Bootstrap.mak linux
	if ! use discord; then
		sed -e '/include.*discord-rpc/d' -i premake5.lua || die
	fi
	"${S}/third_party/premake-core/bin/release/premake5" \
		--scripts="${S}/third_party/premake-core" \
		--file=premake5.lua \
		--os=linux \
		--cc=clang \
		--verbose \
		gmake2 || die "premake5 failed"
}

src_compile() {
	emake -C build/ config=release_linux
}

src_install() {
	dobin "build/bin/Linux/Release/xenia-app"
	make_desktop_entry xenia-app Xenia "" "Game;Emulator"
	dodoc README.md
}
