# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_PV="${PV/_/-}"
MY_COMMIT="cf6cfe9caa6e160d3562742308a38eb3c9014789"
TZDB_VER="230326"
ZBIC_COMMIT="11b08f2712264bbed731545085cbd9702096ceb7"
RESHADE_VER="6.8.0"

DESCRIPTION="Experimental Nintendo Switch 2 emulator based on Eden"
HOMEPAGE="https://eglantine-emu.org/ https://github.com/Eglantine-Community/Eglantine"
SRC_URI="https://github.com/Eglantine-Community/Eglantine/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://git.eden-emu.dev/eden-emu/tzdb_to_nx/releases/download/${TZDB_VER}/${TZDB_VER}.tar.gz -> nx-tzdb-${TZDB_VER}.tar.gz
	https://github.com/kinnay/zbic/archive/${ZBIC_COMMIT}.tar.gz -> zbic-${ZBIC_COMMIT}.tar.gz
	https://github.com/crosire/reshade/archive/v${RESHADE_VER}.tar.gz -> reshade-${RESHADE_VER}.tar.gz"
S="${WORKDIR}/Eglantine-${MY_PV}"

LICENSE="GPL-3+ BSD-2 MIT LGPL-3+ MPL-2.0 Apache-2.0-with-LLVM-exceptions BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="camera +cubeb discord +opengl room sdl +usb web-applet web-service wifi"

RDEPEND="app-arch/lz4
	app-arch/zstd
	dev-cpp/cpp-httplib:=[ssl]
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-libs/quazip[qt6(+)]
	>=dev-libs/sirit-1.0.5
	dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	dev-qt/qtcharts:6
	dev-util/spirv-tools
	games-util/gamemode
	media-libs/libsdl3
	media-libs/libva
	media-libs/opus
	media-video/ffmpeg:=
	net-libs/enet
	virtual/zlib:=
	camera? ( dev-qt/qtmultimedia:6 )
	cubeb? ( media-libs/cubeb )
	discord? ( dev-libs/discord-rpc )
	usb? ( dev-libs/libusb )
	web-applet? ( dev-qt/qtwebengine:6[widgets] )
	wifi? ( net-wireless/wireless-tools )"
DEPEND="${RDEPEND}
	dev-cpp/nlohmann_json
	dev-cpp/simpleini
	dev-libs/boost:=[context]
	dev-libs/frozen
	dev-libs/xbyak
	dev-util/spirv-headers
	dev-util/vulkan-headers
	dev-util/vulkan-utility-libraries
	media-libs/VulkanMemoryAllocator
	web-service? ( dev-cpp/cpp-jwt )"
BDEPEND="dev-qt/qttools:6[linguist]
	dev-util/glslang
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-rename-binaries.patch" )

src_prepare() {
	# CPMUtil applies its own patches only when it downloads a package itself.
	eapply -d "${WORKDIR}/reshade-${RESHADE_VER}" -- .patch/reshade/*.patch
	cmake_src_prepare
	# Read by GetSCMRev in place of git.
	echo "v${MY_PV}" > GIT-TAG || die
	echo "v${MY_PV}" > GIT-RELEASE || die
	echo "${MY_COMMIT}" > GIT-COMMIT || die
	echo nx2 > GIT-REFSPEC || die
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DCPMUTIL_FORCE_SYSTEM=ON
		-DDYNARMIC_USE_LLVM=OFF
		-DENABLE_CUBEB="$(usex cubeb)"
		-DENABLE_LIBUSB="$(usex usb)"
		-DENABLE_OPENGL="$(usex opengl)"
		-DENABLE_QT=ON
		-DENABLE_UPDATE_CHECKER=OFF
		-DENABLE_WEB_SERVICE="$(usex web-service)"
		-DENABLE_WERROR=OFF
		-DENABLE_WIFI_SCAN="$(usex wifi)"
		-DUSE_DISCORD_PRESENCE="$(usex discord)"
		-DYUZU_CMD="$(usex sdl)"
		-DYUZU_DISABLE_LLVM=ON
		-DYUZU_ROOM="$(usex room)"
		-DYUZU_TESTS=OFF
		-DYUZU_TZDB_PATH="${WORKDIR}/nx-tzdb-${TZDB_VER}"
		-DYUZU_USE_QT_MULTIMEDIA="$(usex camera)"
		-DYUZU_USE_QT_WEB_ENGINE="$(usex web-applet)"
		-Dreshade_CUSTOM_DIR="${WORKDIR}/reshade-${RESHADE_VER}"
		-Dreshade_FORCE_BUNDLED=ON
		-Dzbic_CUSTOM_DIR="${WORKDIR}/zbic-${ZBIC_COMMIT}"
		-Dzbic_FORCE_BUNDLED=ON
		-Wno-dev
	)
	cmake_src_configure
}
