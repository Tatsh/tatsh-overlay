# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A lossless video/GIF/image upscaler."
HOMEPAGE="https://video2x.org/ https://github.com/k4yt3x/video2x"
MY_PV="${PV//_/-}"
MY_PV="${MY_PV/beta/beta.}"
LIBREAL_ESRGAN_NCNN_VULKAN_SHA="3e633ddb4f642ad88bd0cd5352b17e64c8c32a61"
SRC_URI="https://github.com/k4yt3x/${PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/k4yt3x/libreal-esrgan-ncnn-vulkan/archive/${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz -> ${PN}-libreal-esrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

DEPEND="dev-libs/ncnn
	dev-libs/spdlog
	media-video/ffmpeg"

S="${WORKDIR}/${PN}-${MY_PV}"

PATCHES=( "${FILESDIR}/${PN}-0001-realesrgan.patch" )

src_prepare() {
	rmdir third_party/libreal_esrgan_ncnn_vulkan || die
	mv "${WORKDIR}/libreal-esrgan-ncnn-vulkan-${LIBREAL_ESRGAN_NCNN_VULKAN_SHA}/src" third_party/realesrgan || die
	sed -re 's/(LIBRARY|ARCHIVE) DESTINATION lib/\1 DESTINATION lib64/' -i third_party/realesrgan/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_NCNN=ON
		-DUSE_SYSTEM_SPDLOG=ON
	)
	cmake_src_configure
}
