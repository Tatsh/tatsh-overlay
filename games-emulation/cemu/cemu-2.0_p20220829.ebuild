# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop wrapper xdg

DESCRIPTION="Wii U emulator."
HOMEPAGE="https://cemu.info/ https://github.com/cemu-project/Cemu"
SHA="d94ecfe078eb4e78500c40daf29c3536edc3041e"
MY_PN="Cemu"
FMT_PV="7.1.3"
GLSLANG_PV="11.8.0"
IMGUI_PV="1.88"
SRC_URI="https://github.com/cemu-project/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/fmtlib/fmt/archive/refs/tags/${FMT_PV}.tar.gz -> ${PN}-fmt-${FMT_PV}.tar.gz
	https://github.com/KhronosGroup/glslang/archive/refs/tags/${GLSLANG_PV}.tar.gz -> ${PN}-glslang-${GLSLANG_PV}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_PV}.tar.gz -> ${PN}-imgui-${IMGUI_PV}.tar.gz"

LICENSE="MPL-2.0 ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lto"

DEPEND="app-arch/zarchive
	app-arch/zstd
	dev-libs/boost
	dev-libs/libzip
	dev-libs/openssl
	dev-libs/pugixml
	dev-libs/rapidjson
	dev-util/vulkan-headers
	media-libs/cubeb
	media-libs/libsdl2[joystick,threads]
	net-misc/curl
	sys-libs/zlib
	x11-libs/wxGTK:3.2-gtk3"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${SHA}"

PATCHES=( "${FILESDIR}/${PN}-deps.patch" )

src_prepare() {
	cmake_src_prepare
	mv "${WORKDIR}/fmt-${FMT_PV}" "${S}/fmt" || die
	mv "${WORKDIR}/glslang-${GLSLANG_PV}" "${S}/glslang" || die
	mv "${WORKDIR}/imgui-${IMGUI_PV}" "${S}/imgui" || die
	cp "${FILESDIR}/${PN}-imgui-CMakeLists.txt" imgui/CMakeLists.txt || die
	cp "${FILESDIR}/${PN}-imgui-config.cmake.in" imgui/imgui-config.cmake.in || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=$(usex lto)
		-DENABLE_CUBEB=ON
		-DENABLE_DISCORD_RPC=OFF
		-DENABLE_OPENGL=ON
		-DENABLE_SDL=ON
		-DENABLE_VULKAN=ON
		-DENABLE_WXWIDGETS=ON
		-DPUBLIC_RELEASE=ON
		-DwxWidgets_CONFIG_EXECUTABLE=/usr/$(get_libdir)/wx/config/gtk3-unicode-3.2-gtk3
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	exeinto /usr/$(get_libdir)/${PN}
	newexe "${BUILD_DIR}/src/${MY_PN}2" "${PN}"
	insinto /usr/$(get_libdir)/${PN}
	doins -r bin/*
	einstalldocs
	make_wrapper "${PN}" "/usr/$(get_libdir)/${PN}/${PN}" "/usr/$(get_libdir)/${PN}"
	newicon -s 128 src/resource/logo_icon.png "info.${PN}.${MY_PN}.png"
	domenu "dist/linux/info.${PN}.${MY_PN}.desktop"
}
