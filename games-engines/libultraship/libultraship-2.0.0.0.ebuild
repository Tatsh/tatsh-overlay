# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

# Upstream pulls every one of these with FetchContent at configure time, which
# is not allowed here, so they are fetched as distfiles and redirected with
# FETCHCONTENT_SOURCE_DIR_*. StormLib and tinycc are only used when
# INCLUDE_MPQ_SUPPORT or ENABLE_SCRIPTING are on, and libgfxd only when
# GFX_DEBUG_DISASSEMBLER is, so none of the three are needed here.
IMGUI_PV="1.91.9b-docking"
MONOCYPHER_COMMIT="0d85f98c9d9b0227e42cf795cb527dff372b40a4"
PRISM_COMMIT="1de054450e7b3c5f777d2e3dfcb228ad120c329d"
STB_COMMIT="0bc88af4de5fb022db643c2d8e549a0927749354"
THREADPOOL_PV="4.1.0"

DESCRIPTION="Cross-platform runtime for Nintendo 64 game ports."
HOMEPAGE="https://github.com/Kenix3/libultraship"
SRC_URI="https://github.com/Kenix3/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_PV}.tar.gz
	-> imgui-${IMGUI_PV}.tar.gz
	https://github.com/bshoshany/thread-pool/archive/refs/tags/v${THREADPOOL_PV}.tar.gz
	-> thread-pool-${THREADPOOL_PV}.tar.gz
	https://github.com/KiritoDv/prism-processor/archive/${PRISM_COMMIT}.tar.gz
	-> prism-processor-${PRISM_COMMIT}.tar.gz
	https://github.com/LoupVaillant/Monocypher/archive/${MONOCYPHER_COMMIT}.tar.gz
	-> monocypher-${MONOCYPHER_COMMIT}.tar.gz
	https://github.com/nothings/stb/raw/${STB_COMMIT}/stb_image.h
	-> stb_image.h-${STB_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libzip:=
	dev-libs/spdlog:=
	dev-libs/tinyxml2:=
	media-libs/libglvnd
	media-libs/libsdl3
"
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/python:*"

PATCHES=( "${FILESDIR}/${P}-shared-install.patch" )

src_prepare() {
	# FETCHCONTENT_SOURCE_DIR_* skips the patch step, so apply upstream's own
	# ImGui patch here instead.
	pushd "${WORKDIR}/imgui-${IMGUI_PV}" >/dev/null || die
	eapply "${S}/cmake/dependencies/patches/imgui-fixes-and-config.patch"
	popd >/dev/null || die

	# One dependency is a plain header fetched with file(DOWNLOAD). Unlike
	# DOWNLOAD, COPY_FILE does not create the destination directory.
	sed -i -e "s|file(DOWNLOAD \"https://github.com/nothings/stb/raw/[^\"]*\" |file(MAKE_DIRECTORY \"\${STB_DIR}\")\nfile(COPY_FILE \"${DISTDIR}/stb_image.h-${STB_COMMIT}\" |" \
		cmake/dependencies/common.cmake || die
	grep -q 'file(COPY_FILE' cmake/dependencies/common.cmake ||
		die "failed to redirect the stb_image.h download"

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		# The bundled ImGui, stb and monocypher stay static and are linked
		# into the shared library, so they have to be position independent.
		-DCMAKE_POSITION_INDEPENDENT_CODE=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_IMGUI="${WORKDIR}/imgui-${IMGUI_PV}"
		-DFETCHCONTENT_SOURCE_DIR_MONOCYPHER="${WORKDIR}/Monocypher-${MONOCYPHER_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_PRISM="${WORKDIR}/prism-processor-${PRISM_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_THREADPOOL="${WORKDIR}/thread-pool-${THREADPOOL_PV}"
		-DLUS_BUILD_TESTS=OFF
	)

	cmake_src_configure
}
