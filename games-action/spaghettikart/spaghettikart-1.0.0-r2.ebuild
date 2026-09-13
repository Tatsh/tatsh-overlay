# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic xdg

MY_PN="SpaghettiKart"
# The executable and CMake project are named after neither the repository nor
# the game.
MY_TARGET="Spaghettify"

# Submodules. doxygen-awesome-css and tools/blender/fast64 are documentation
# and Blender tooling and are not part of the build.
LUS_COMMIT="f40cfd33b8bc6237d635d4ed82838a7e3f785386"
# This one is no longer reachable from any branch of HarbourMasters/Torch, but
# GitHub still serves the archive for it.
TORCH_COMMIT="2d474ddb8da8b213fbdbb49d0273ce31fa955f35"
# Fetched with FetchContent by SpaghettiKart itself.
DR_LIBS_COMMIT="da35f9d6c7374a95353fd1df1d394d44ab66cf01"
# Fetched by SpaghettiKart with a bare file(DOWNLOAD), which leaves an empty
# file behind instead of failing when there is no network. sse2neon.h is
# fetched the same way, but from a branch rather than a tag, so it cannot be
# mirrored; nothing includes it on amd64 and the empty file is harmless there.
SEMVER_PV="1.0.0-rc"
TOMLPLUSPLUS_PV="3.4.0"
# Fetched with FetchContent by libultraship. MPQ support is off by default in
# this revision, so StormLib is not needed.
IMGUI_PV="1.91.9b-docking"
PRISM_COMMIT="bbcbc7e3f890a5806b579361e7aa0336acd547e7"
STB_COMMIT="0bc88af4de5fb022db643c2d8e549a0927749354"
THREADPOOL_PV="4.1.0"
# Fetched with FetchContent by Torch. GSL is not listed: Torch only fetches it
# when it detects it is running under WSL.
LIBGFXD_COMMIT="96fd3b849f38b3a7c7b7f3ff03c5921d328e6cdf"
TINYXML2_PV="10.0.0"
YAML_CPP_COMMIT="2f86d13775d119edbb69af52e5f566fd65c6953b"

DESCRIPTION="Mario Kart 64 port to modern platforms."
HOMEPAGE="https://github.com/HarbourMasters/SpaghettiKart"
SRC_URI="https://github.com/HarbourMasters/${MY_PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Kenix3/libultraship/archive/${LUS_COMMIT}.tar.gz
	-> libultraship-${LUS_COMMIT}.tar.gz
	https://github.com/HarbourMasters/Torch/archive/${TORCH_COMMIT}.tar.gz
	-> Torch-${TORCH_COMMIT}.tar.gz
	https://github.com/mackron/dr_libs/archive/${DR_LIBS_COMMIT}.tar.gz
	-> dr_libs-${DR_LIBS_COMMIT}.tar.gz
	https://raw.githubusercontent.com/Neargye/semver/refs/tags/v${SEMVER_PV}/include/semver.hpp
	-> semver.hpp-${SEMVER_PV}
	https://github.com/marzer/tomlplusplus/archive/refs/tags/v${TOMLPLUSPLUS_PV}.tar.gz
	-> tomlplusplus-${TOMLPLUSPLUS_PV}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_PV}.tar.gz
	-> imgui-${IMGUI_PV}.tar.gz
	https://github.com/KiritoDv/prism-processor/archive/${PRISM_COMMIT}.tar.gz
	-> prism-processor-${PRISM_COMMIT}.tar.gz
	https://github.com/nothings/stb/raw/${STB_COMMIT}/stb_image.h
	-> stb_image.h-${STB_COMMIT}
	https://github.com/bshoshany/thread-pool/archive/refs/tags/v${THREADPOOL_PV}.tar.gz
	-> thread-pool-${THREADPOOL_PV}.tar.gz
	https://github.com/glankk/libgfxd/archive/${LIBGFXD_COMMIT}.tar.gz
	-> libgfxd-${LIBGFXD_COMMIT}.tar.gz
	https://github.com/leethomason/tinyxml2/archive/refs/tags/${TINYXML2_PV}.tar.gz
	-> tinyxml2-${TINYXML2_PV}.tar.gz
	https://github.com/jbeder/yaml-cpp/archive/${YAML_CPP_COMMIT}.tar.gz
	-> yaml-cpp-${YAML_CPP_COMMIT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libzip:=
	dev-libs/spdlog:=
	dev-libs/tinyxml2:=
	media-libs/glew:=
	media-libs/libglvnd
	media-libs/libogg
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/sdl2-net
"
DEPEND="${RDEPEND}"
BDEPEND="dev-lang/python:*"

PATCHES=(
	"${FILESDIR}/${P}-torch-single-build.patch"
	"${FILESDIR}/${P}-use-torch-cli.patch"
	"${FILESDIR}/${P}-dialogs-via-pfd.patch"
)

src_prepare() {
	rm -rf libultraship torch || die
	mv "${WORKDIR}/libultraship-${LUS_COMMIT}" libultraship || die
	mv "${WORKDIR}/Torch-${TORCH_COMMIT}" torch || die

	# libultraship fetches this header with file(DOWNLOAD). Unlike DOWNLOAD,
	# COPY_FILE does not create the destination directory.
	sed -i -e "s|file(DOWNLOAD \"https://github.com/nothings/stb/raw/[^\"]*\" |file(MAKE_DIRECTORY \"\${STB_DIR}\")\nfile(COPY_FILE \"${DISTDIR}/stb_image.h-${STB_COMMIT}\" |" \
		libultraship/cmake/dependencies/common.cmake || die
	grep -q 'file(COPY_FILE' libultraship/cmake/dependencies/common.cmake ||
		die "failed to redirect the stb_image.h download"

	# Same again for SpaghettiKart's own semver.hpp. file(DOWNLOAD) reports
	# failure only through a STATUS variable, and there is none here, so with
	# no network the configure succeeds and leaves an empty header behind.
	# ModMetadata::version is then dropped and ModManager.cpp fails to compile.
	sed -i -e "s|file(DOWNLOAD \"https://raw.githubusercontent.com/Neargye/semver/[^\"]*\" |file(MAKE_DIRECTORY \"\${SEMVER_DIR}\")\nfile(COPY_FILE \"${DISTDIR}/semver.hpp-${SEMVER_PV}\" |" \
		CMakeLists.txt || die
	grep -q 'file(COPY_FILE' CMakeLists.txt ||
		die "failed to redirect the semver.hpp download"

	cmake_src_prepare

	# FETCHCONTENT_SOURCE_DIR_* skips the patch step, so apply upstream's own
	# ImGui patch here instead.
	pushd "${WORKDIR}/imgui-${IMGUI_PV}" >/dev/null || die
	eapply "${S}/libultraship/cmake/dependencies/patches/imgui-fixes-and-config.patch"
	popd >/dev/null || die
}

src_configure() {
	# The vendored ImGui and prism violate the ODR across translation units.
	filter-lto

	local mycmakeargs=(
		# yaml-cpp and tinyxml2 otherwise build as shared libraries that
		# nothing installs, leaving the executable with sonames it cannot
		# resolve.
		-DBUILD_SHARED_LIBS=OFF
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_DR_LIBS="${WORKDIR}/dr_libs-${DR_LIBS_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_IMGUI="${WORKDIR}/imgui-${IMGUI_PV}"
		-DFETCHCONTENT_SOURCE_DIR_LIBGFXD="${WORKDIR}/libgfxd-${LIBGFXD_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_PRISM="${WORKDIR}/prism-processor-${PRISM_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_THREADPOOL="${WORKDIR}/thread-pool-${THREADPOOL_PV}"
		-DFETCHCONTENT_SOURCE_DIR_TINYXML2="${WORKDIR}/tinyxml2-${TINYXML2_PV}"
		-DFETCHCONTENT_SOURCE_DIR_TOMLPLUSPLUS="${WORKDIR}/tomlplusplus-${TOMLPLUSPLUS_PV}"
		-DFETCHCONTENT_SOURCE_DIR_YAML-CPP="${WORKDIR}/yaml-cpp-${YAML_CPP_COMMIT}"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	# spaghetti.o2r holds the port's own assets and is the only thing upstream
	# installs. It is built by a custom target that is not part of all.
	cmake_src_compile GenerateO2R
}

src_install() {
	# libultraship looks for the port's own assets next to the executable and
	# writes everything else relative to the working directory, so the
	# executable goes where spaghetti.o2r can sit beside it and a wrapper picks
	# the writable directory. SHIP_HOME is libultraship's own override for the
	# latter; the cd is for the paths that ignore it.
	exeinto "/usr/libexec/${PN}"
	newexe "${BUILD_DIR}/${MY_TARGET}" "${MY_TARGET}"

	insinto "/usr/libexec/${PN}"
	doins "${BUILD_DIR}/spaghetti.o2r"

	cat > "${T}/${PN}" <<-EOF || die
		#!/bin/sh
		SHIP_HOME="\${XDG_DATA_HOME:-\${HOME}/.local/share}/${PN}"
		export SHIP_HOME
		mkdir -p "\${SHIP_HOME}" || exit 1
		cd "\${SHIP_HOME}" || exit 1
		exec "${EPREFIX}/usr/libexec/${PN}/${MY_TARGET}" "\$@"
	EOF
	dobin "${T}/${PN}"

	# Upstream's SpaghettiKart.desktop is written for an AppImage: it runs
	# Spaghettify and asks for the far too generic Icon=icon. Generate an entry
	# for the installed binary instead, with the icon renamed to match.
	newicon -s 256 icon.png "${PN}.png"
	make_desktop_entry "${PN}" "${MY_PN}" "${PN}" Game

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "${MY_PN} needs assets extracted from a US Mario Kart 64 ROM. Run it"
	elog "once and it will ask for the ROM, then write mk64.o2r and everything"
	elog "else it saves to \${XDG_DATA_HOME}/${PN}."
	elog
	elog "Asking for the ROM needs one of zenity, kdialog, matedialog or qarma"
	elog "installed; without one ${MY_PN} cannot prompt and will exit."
}
