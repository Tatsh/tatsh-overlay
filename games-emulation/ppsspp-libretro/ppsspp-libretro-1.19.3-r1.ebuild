# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBRETRO_COMMIT_SHA="dummy"
LIBRETRO_REPO_NAME="hrydgard/ppsspp"

inherit cmake libretro libretro-core

DESCRIPTION="Libretro port of PPSSPP"
HOMEPAGE="https://www.ppsspp.org/"
SRC_URI="https://github.com/hrydgard/ppsspp/releases/download/v${PV}/ppsspp-${PV}.tar.xz -> ${P}.tar.xz"

S="${WORKDIR}"/ppsspp-${PV}
LICENSE="Apache-2.0 BSD BSD-2 GPL-2 JSON MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="opengl gles2 vulkan X +wayland gbm system-ffmpeg"
RESTRICT="test"
REQUIRED_USE="
	|| ( gbm wayland X )
	opengl? ( !gles2 )
	gbm? ( !X )
"

RDEPEND="
	app-arch/snappy:=
	app-arch/zstd:=
	dev-libs/libzip:=
	media-libs/libpng:=
	media-libs/libsdl2[joystick]
	system-ffmpeg? ( media-video/ffmpeg:0/58.60.60 )
	virtual/zlib:=
	opengl? (
		virtual/opengl
		media-libs/glew:=
		)
	gles2? ( media-libs/mesa )
	vulkan? ( media-libs/vulkan-loader )
	wayland? ( media-libs/mesa[wayland] )
	X? ( media-libs/mesa[X] )
	games-emulation/libretro-info
"
DEPEND="${RDEPEND}"
ASSETS_DIR="${LIBRETRO_DATA_DIR}"/PPSSPP

PATCHES=(
	"${FILESDIR}/ppsspp-1.17.1-SpvBuilder-cstdint.patch"
	"${FILESDIR}/ppsspp-1.17.1-cmake-cxx.patch"
)

src_prepare() {
	if ! use system-ffmpeg; then
		pushd ffmpeg > /dev/null || die
		[[ "${ARCH}" != "amd64" ]] || ./linux_x86-64.sh
		[[ "${ARCH}" != "x86" ]] || ./linux_x86.sh
		[[ "${ARCH}" != "arm64" ]] || ./linux_arm64_native.sh
		popd > /dev/null || die
	fi
	cmake_src_prepare
}

src_configure() {
	# -DBUILD_SHARED_LIBS=OFF is required for using internal glslang instead of system glslang.
	# ppsspp-libretro is sometimes incompatible with system glslang.
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCMAKE_SKIP_RPATH=ON
		-DHEADLESS=false
		-DUSE_MINIUPNPC=OFF
		-DUSE_SYSTEM_FFMPEG="$(usex system-ffmpeg)"
		-DUSE_SYSTEM_LIBZIP=ON
		-DUSE_SYSTEM_SNAPPY=ON
		-DUSE_SYSTEM_ZSTD=ON
		-DUSE_DISCORD=OFF
		-DUSING_QT_UI=OFF
		-DUSING_GLES2="$(usex gles2)"
		-DLIBRETRO=ON
	)

	if use wayland; then
		mycmakeargs+=( -DUSE_WAYLAND_WSI=ON )
	fi

	if use vulkan; then
		mycmakeargs+=( -DVULKAN=ON )
		if use gbm; then
			mycmakeargs+=( -DUSE_VULKAN_DISPLAY_KHR=ON )
		fi
		mycmakeargs+=( -DUSING_X11_VULKAN="$(usex X)" )
	fi

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	LIBRETRO_CORE_LIB_FILE="${BUILD_DIR}"/lib/ppsspp_libretro.so
	libretro-core_src_install

	insinto "${ASSETS_DIR}"
	doins -r "${BUILD_DIR}"/assets/*
}

pkg_postinst() {
	ewarn ""
	ewarn "You need to symlink \"/${ASSETS_DIR}\""
	ewarn "to the \"system_directory/\" directory of your user."
	ewarn "As retroarch user:"
	ewarn "When upgrading from old assets:"
	ewarn "\$ rm -r ~/.config/retroarch/system/PPSSPP/"
	ewarn "To symlink the assets:"
	ewarn "\$ mkdir -p ~/.config/retroarch/system"
	ewarn "\$ ln -s /${ASSETS_DIR} ~/.config/retroarch/system/"
	ewarn ""
	ewarn ""
}
