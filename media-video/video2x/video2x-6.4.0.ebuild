# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A lossless video/GIF/image upscaler."
HOMEPAGE="https://video2x.org/ https://github.com/k4yt3x/video2x"
LIBREAL_ESRGAN_NCNN_VULKAN_SHA="c1f255524f79566c40866b38e5e65b40adf77eee"
LIBRIFE_NCNN_VULKAN_SHA="3f7bcb44f38b2acda6fa5e575a6d12517ac16b94"
LIBREALCUGAN_NCNN_VULKAN_SHA="d9c5a7eb4c8475af6110496c27c3d1f702f9b96a"
SRC_URI="https://github.com/k4yt3x/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/k4yt3x/libreal-esrgan-ncnn-vulkan/archive/${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz -> ${PN}-libreal-esrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz
	https://github.com/k4yt3x/librife-ncnn-vulkan/archive/${LIBRIFE_NCNN_VULKAN_SHA}.tar.gz -> ${PN}-librife-ncnn-vulkan-${LIBRIFE_NCNN_VULKAN_SHA}.tar.gz
	https://github.com/k4yt3x/librealcugan-ncnn-vulkan/archive/${LIBREALCUGAN_NCNN_VULKAN_SHA}.tar.gz -> ${PN}-librealcugan-ncnn-vulkan-${LIBREALCUGAN_NCNN_VULKAN_SHA}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

DEPEND="dev-libs/boost:=
	dev-libs/ncnn:=
	dev-libs/spdlog:=
	media-gfx/realesrgan-ncnn-vulkan:=
	media-libs/opencv:=
	media-video/ffmpeg:=
	dev-libs/libfmt
	media-libs/vulkan-loader"

PATCHES=( "${FILESDIR}/${PN}-0001-build-system-fix.patch" )

src_prepare() {
	rmdir "${S}/third_party/lib"{realesrgan,realcugan,rife}_ncnn_vulkan || die
	mv "${WORKDIR}/librealcugan-ncnn-vulkan-${LIBREALCUGAN_NCNN_VULKAN_SHA}" "${S}/third_party/librealcugan_ncnn_vulkan" || die
	mv "${WORKDIR}/librealesrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}" "${S}/third_party/librealesrgan_ncnn_vulkan" || die
	mv "${WORKDIR}/librife-ncnn-vulkan-${LIBRIFE_NCNN_VULKAN_SHA}" "${S}/third_party/librife_ncnn_vulkan" || die
	sed -re 's/(LIBRARY|ARCHIVE) DESTINATION lib/\1 DESTINATION lib64/' -i third_party/libr*/src/CMakeLists.txt || die
	sed -re 's/generate-spirv/generate-spirv2/g' -i third_party/librife_ncnn_vulkan/src/CMakeLists.txt || die
	sed -re 's/generate-spirv/generate-spirv3/g' -i third_party/librealcugan_ncnn_vulkan/src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_NCNN=ON
		-Wno-dev
	)
	cmake_src_configure
}
