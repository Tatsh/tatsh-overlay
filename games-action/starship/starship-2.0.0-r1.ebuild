# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop flag-o-matic xdg

MY_PN="Starship"

# Submodules.
LUS_COMMIT="45c4f8d6c19c6176f5e0918917c655ea09ecc212"
TORCH_COMMIT="f75facb20883570ed091e8ae733ec0539f606e57"
# Fetched with FetchContent by Starship itself.
DR_LIBS_COMMIT="da35f9d6c7374a95353fd1df1d394d44ab66cf01"
# Fetched with FetchContent by libultraship.
IMGUI_PV="1.91.9b-docking"
PRISM_COMMIT="7ae724a6fb7df8cbf547445214a1a848aefef747"
STB_COMMIT="0bc88af4de5fb022db643c2d8e549a0927749354"
# This libultraship gates MPQ support on EXCLUDE_MPQ_SUPPORT, which is off, so
# StormLib is not optional here.
STORMLIB_PV="9.25"
THREADPOOL_PV="4.1.0"
# Fetched with FetchContent by Torch. GSL is not listed: Torch only fetches it
# when it detects it is running under WSL.
LIBGFXD_COMMIT="96fd3b849f38b3a7c7b7f3ff03c5921d328e6cdf"
TINYXML2_PV="10.0.0"
YAML_CPP_COMMIT="28f93bdec6387d42332220afa9558060c8016795"

DESCRIPTION="Star Fox 64 port to modern platforms."
HOMEPAGE="https://github.com/HarbourMasters/Starship"
SRC_URI="https://github.com/HarbourMasters/${MY_PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz
	https://github.com/Kenix3/libultraship/archive/${LUS_COMMIT}.tar.gz
	-> libultraship-${LUS_COMMIT}.tar.gz
	https://github.com/HarbourMasters/Torch/archive/${TORCH_COMMIT}.tar.gz
	-> Torch-${TORCH_COMMIT}.tar.gz
	https://github.com/mackron/dr_libs/archive/${DR_LIBS_COMMIT}.tar.gz
	-> dr_libs-${DR_LIBS_COMMIT}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_PV}.tar.gz
	-> imgui-${IMGUI_PV}.tar.gz
	https://github.com/KiritoDv/prism-processor/archive/${PRISM_COMMIT}.tar.gz
	-> prism-processor-${PRISM_COMMIT}.tar.gz
	https://github.com/nothings/stb/raw/${STB_COMMIT}/stb_image.h
	-> stb_image.h-${STB_COMMIT}
	https://github.com/bshoshany/thread-pool/archive/refs/tags/v${THREADPOOL_PV}.tar.gz
	-> thread-pool-${THREADPOOL_PV}.tar.gz
	https://github.com/ladislav-zezula/StormLib/archive/refs/tags/v${STORMLIB_PV}.tar.gz
	-> StormLib-${STORMLIB_PV}.tar.gz
	https://github.com/glankk/libgfxd/archive/${LIBGFXD_COMMIT}.tar.gz
	-> libgfxd-${LIBGFXD_COMMIT}.tar.gz
	https://github.com/leethomason/tinyxml2/archive/refs/tags/${TINYXML2_PV}.tar.gz
	-> tinyxml2-${TINYXML2_PV}.tar.gz
	https://github.com/jbeder/yaml-cpp/archive/${YAML_CPP_COMMIT}.tar.gz
	-> yaml-cpp-${YAML_CPP_COMMIT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="CC0-1.0"
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
)

src_prepare() {
	# Submodules.
	rm -rf libultraship tools/Torch || die
	mv "${WORKDIR}/libultraship-${LUS_COMMIT}" libultraship || die
	mv "${WORKDIR}/Torch-${TORCH_COMMIT}" tools/Torch || die

	# libultraship fetches this header with file(DOWNLOAD). Unlike DOWNLOAD,
	# COPY_FILE does not create the destination directory.
	sed -i -e "s|file(DOWNLOAD \"https://github.com/nothings/stb/raw/[^\"]*\" |file(MAKE_DIRECTORY \"\${STB_DIR}\")\nfile(COPY_FILE \"${DISTDIR}/stb_image.h-${STB_COMMIT}\" |" \
		libultraship/cmake/dependencies/common.cmake || die
	grep -q 'file(COPY_FILE' libultraship/cmake/dependencies/common.cmake ||
		die "failed to redirect the stb_image.h download"

	cmake_src_prepare

	# FETCHCONTENT_SOURCE_DIR_* skips the patch step, so apply upstream's own
	# dependency patches here instead.
	pushd "${WORKDIR}/imgui-${IMGUI_PV}" >/dev/null || die
	eapply "${S}/libultraship/cmake/dependencies/patches/imgui-fixes-and-config.patch"
	popd >/dev/null || die

	pushd "${WORKDIR}/StormLib-${STORMLIB_PV}" >/dev/null || die
	eapply "${S}/libultraship/cmake/dependencies/patches/stormlib-optimizations.patch"
	popd >/dev/null || die
}

src_configure() {
	# The vendored ImGui and prism violate the ODR across translation units.
	filter-lto

	local mycmakeargs=(
		# StormLib, yaml-cpp and tinyxml2 otherwise build as shared libraries
		# that nothing installs, leaving the executable with sonames it cannot
		# resolve.
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_STORMLIB=OFF
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_SOURCE_DIR_DR_LIBS="${WORKDIR}/dr_libs-${DR_LIBS_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_IMGUI="${WORKDIR}/imgui-${IMGUI_PV}"
		-DFETCHCONTENT_SOURCE_DIR_LIBGFXD="${WORKDIR}/libgfxd-${LIBGFXD_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_PRISM="${WORKDIR}/prism-processor-${PRISM_COMMIT}"
		-DFETCHCONTENT_SOURCE_DIR_STORMLIB="${WORKDIR}/StormLib-${STORMLIB_PV}"
		-DFETCHCONTENT_SOURCE_DIR_THREADPOOL="${WORKDIR}/thread-pool-${THREADPOOL_PV}"
		-DFETCHCONTENT_SOURCE_DIR_TINYXML2="${WORKDIR}/tinyxml2-${TINYXML2_PV}"
		-DFETCHCONTENT_SOURCE_DIR_YAML-CPP="${WORKDIR}/yaml-cpp-${YAML_CPP_COMMIT}"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	# starship.o2r holds the port's own assets and is the only thing upstream
	# installs. It is built by a custom target that is not part of all.
	cmake_src_compile GeneratePortO2R
}

src_install() {
	dobin "${BUILD_DIR}/${MY_PN}"

	insinto "/usr/share/${PN}"
	doins "${BUILD_DIR}/${PN}.o2r"

	# Upstream's Starship.desktop is written for an AppImage and asks for the far
	# too generic Icon=logo. Generate an entry for the installed binary instead,
	# with the icon renamed to match.
	newicon -s 512 logo.png "${PN}.png"
	make_desktop_entry "${MY_PN}" "${MY_PN}" "${PN}" Game

	einstalldocs
}

pkg_postinst() {
	xdg_pkg_postinst

	elog "${MY_PN} needs assets extracted from a US 1.0 or 1.1 Star Fox 64"
	elog "ROM. Run it once and it will ask for the ROM; the port's own assets"
	elog "are installed in /usr/share/${PN}."
}
