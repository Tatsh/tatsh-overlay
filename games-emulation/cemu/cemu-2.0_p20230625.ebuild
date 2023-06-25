# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Wii U emulator."
HOMEPAGE="https://cemu.info/ https://github.com/cemu-project/Cemu"
SHA="9499870cc993f39d8c25f5e434a4d25d9a24b556"
MY_PN="Cemu"
IMGUI_PV="1.88"
SRC_URI="https://github.com/cemu-project/${MY_PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz
	https://github.com/ocornut/imgui/archive/refs/tags/v${IMGUI_PV}.tar.gz -> ${PN}-imgui-${IMGUI_PV}.tar.gz"

LICENSE="MPL-2.0 ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+cubeb discord +sdl +vulkan"

DEPEND="app-arch/zarchive
	app-arch/zstd
	cubeb? ( media-libs/cubeb )
	dev-libs/boost
	dev-libs/glib
	>=dev-libs/libfmt-9.1.0:=
	dev-libs/libzip
	dev-libs/openssl
	dev-libs/pugixml
	dev-libs/rapidjson
	dev-libs/wayland
	dev-util/glslang
	media-libs/libglvnd
	media-libs/libsdl2[haptic,joystick,threads]
	net-misc/curl
	sys-libs/zlib
	vulkan? ( dev-util/vulkan-headers )
	x11-libs/gtk+:3[wayland]
	x11-libs/libX11
	x11-libs/wxGTK:3.2-gtk3[opengl]"
RDEPEND="${DEPEND}"
BDEPEND="media-libs/glm"

S="${WORKDIR}/${MY_PN}-${SHA}"

PATCHES=(
	"${FILESDIR}/${PN}-0002-remove-default-from-system-g.patch"
)

src_prepare() {
	sed -re \
		's/^target_link_libraries\(CemuBin.*/target_link_libraries(CemuBin PRIVATE wayland-client/' \
		-i src/CMakeLists.txt || die
	cmake_src_prepare
	rmdir dependencies/imgui || die
	mv "${WORKDIR}/imgui-${IMGUI_PV}" dependencies/imgui || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		"-DENABLE_CUBEB=$(usex cubeb)"
		"-DENABLE_DISCORD_RPC=$(usex discord)"
		-DENABLE_OPENGL=ON
		"-DENABLE_SDL=$(usex sdl)"
		-DENABLE_VCPKG=OFF
		"-DENABLE_VULKAN=$(usex vulkan)"
		-DENABLE_WXWIDGETS=ON
		-DPORTABLE=OFF
		"-DwxWidgets_CONFIG_EXECUTABLE=/usr/$(get_libdir)/wx/config/gtk3-unicode-3.2-gtk3"
		-Wno-dev
	)
	cmake_src_configure
}

src_install() {
	newbin "bin/${MY_PN}_relwithdebinfo" "$MY_PN"
	insinto "/usr/share/${PN}/gameProfiles"
	doins -r bin/gameProfiles/default/*
	insinto "/usr/share/${PN}"
	doins -r bin/resources bin/shaderCache
	einstalldocs
	newicon -s 128 src/resource/logo_icon.png "info.${PN}.${MY_PN}.png"
	domenu "dist/linux/info.${PN}.${MY_PN}.desktop"
}
