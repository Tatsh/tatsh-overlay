# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

MY_TAG="build-${PV##*_p}"
MY_COMMIT="9c9a1dfa56973c26fa1159f323c05e307496e17c"
TZDB_VER="230326"
ZBIC_COMMIT="11b08f2712264bbed731545085cbd9702096ceb7"
RESHADE_VER="6.8.0"
# Pinned upstream so NUP archives compress byte-identically everywhere.
ZSTD_COMMIT="33618c89e511637f8a6ef955b3501766d71feb53"

DESCRIPTION="Experimental Nintendo Switch 2 emulator based on Eden"
HOMEPAGE="https://github.com/zortos293/Lichii"
SRC_URI="https://github.com/zortos293/Lichii/archive/refs/tags/${MY_TAG}.tar.gz -> ${P}.tar.gz
	https://git.eden-emu.dev/eden-emu/tzdb_to_nx/releases/download/${TZDB_VER}/${TZDB_VER}.tar.gz -> nx-tzdb-${TZDB_VER}.tar.gz
	https://github.com/kinnay/zbic/archive/${ZBIC_COMMIT}.tar.gz -> zbic-${ZBIC_COMMIT}.tar.gz
	https://github.com/crosire/reshade/archive/v${RESHADE_VER}.tar.gz -> reshade-${RESHADE_VER}.tar.gz
	https://github.com/facebook/zstd/archive/${ZSTD_COMMIT}.tar.gz -> zstd-${ZSTD_COMMIT}.tar.gz"
S="${WORKDIR}/Lichii-${MY_TAG}"

LICENSE="GPL-3+ BSD-2 MIT LGPL-3+ MPL-2.0 Apache-2.0-with-LLVM-exceptions BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="camera +cubeb discord +opengl room sdl +usb web-applet web-service wifi"

RDEPEND="app-arch/lz4
	dev-cpp/cpp-httplib:=[ssl]
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-libs/quazip[qt6(+)]
	>=dev-libs/sirit-1.0.5
	dev-qt/qtbase:6[concurrent,dbus,gui,widgets]
	dev-qt/qtcharts:6
	dev-util/spirv-tools
	games-util/gamemode
	>=media-libs/libsdl3-3.2.10
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
	>=dev-libs/xxhash-0.8.3
	dev-util/spirv-headers
	dev-util/vulkan-headers
	dev-util/vulkan-utility-libraries
	media-libs/VulkanMemoryAllocator
	web-service? ( dev-cpp/cpp-jwt )"
BDEPEND="dev-util/glslang
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}-rename-binaries.patch" )

src_prepare() {
	# CPMUtil applies its own patches only when it downloads a package itself.
	eapply -d "${WORKDIR}/reshade-${RESHADE_VER}" -- .patch/reshade/*.patch
	cmake_src_prepare
	# Read by GetSCMRev in place of git.
	echo "${MY_TAG}" > GIT-TAG || die
	echo "${MY_TAG}" > GIT-RELEASE || die
	echo "${MY_COMMIT}" > GIT-COMMIT || die
	echo nx2 > GIT-REFSPEC || die
	# Header-only; a directory of its own keeps -I/usr/include off the command line.
	mkdir "${T}/xxhash" || die
	ln -s "${ESYSROOT}/usr/include/xxhash.h" "${T}/xxhash/xxhash.h" || die
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
		-DLICHII_CMD="$(usex sdl)"
		-DLICHII_DISABLE_LLVM=ON
		-DLICHII_ROOM="$(usex room)"
		-DLICHII_TESTS=OFF
		-DLICHII_TZDB_PATH="${WORKDIR}/nx-tzdb-${TZDB_VER}"
		-DLICHII_USE_QT_MULTIMEDIA="$(usex camera)"
		-DLICHII_USE_QT_WEB_ENGINE="$(usex web-applet)"
		-DUSE_DISCORD_PRESENCE="$(usex discord)"
		-Dreshade_CUSTOM_DIR="${WORKDIR}/reshade-${RESHADE_VER}"
		-Dreshade_FORCE_BUNDLED=ON
		-Dxxhash_CUSTOM_DIR="${T}/xxhash"
		-Dxxhash_FORCE_BUNDLED=ON
		-Dzbic_CUSTOM_DIR="${WORKDIR}/zbic-${ZBIC_COMMIT}"
		-Dzbic_FORCE_BUNDLED=ON
		-Dzstd_CUSTOM_DIR="${WORKDIR}/zstd-${ZSTD_COMMIT}"
		-Wno-dev
	)
	cmake_src_configure
}
