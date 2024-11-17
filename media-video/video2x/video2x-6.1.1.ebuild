# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A lossless video/GIF/image upscaler."
HOMEPAGE="https://video2x.org/ https://github.com/k4yt3x/video2x"
LIBREAL_ESRGAN_NCNN_VULKAN_SHA="cd68df6f98f036fcc9e7d63597ea6faa427c2d2d"
SRC_URI="https://github.com/k4yt3x/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/k4yt3x/libreal-esrgan-ncnn-vulkan/archive/${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz -> ${PN}-libreal-esrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

DEPEND="dev-libs/boost:=
	dev-libs/ncnn:=
	dev-libs/spdlog:=
	media-gfx/realesrgan-ncnn-vulkan:=
	media-libs/opencv:=
	media-video/ffmpeg:="

PATCHES=( "${FILESDIR}/${PN}-0001-build-system-fix.patch" )

src_prepare() {
	rmdir "${S}/third_party/librealesrgan_ncnn_vulkan" || die
	mv "${WORKDIR}/librealesrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}/src" "${S}/third_party/realesrgan" || die
	sed -re 's/(LIBRARY|ARCHIVE) DESTINATION lib/\1 DESTINATION lib64/' -i third_party/realesrgan/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DBUILD_STATIC_LIBS=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_NCNN=ON
		-DUSE_SYSTEM_OPENCV=ON
		-DUSE_SYSTEM_SPDLOG=ON
		-Wno-dev
	)
	cmake_src_configure
}
