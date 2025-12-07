# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="RealESRGAN super resolution plugin for VapourSynth"
HOMEPAGE="https://github.com/Tatsh/VapourSynth-Real-ESRGAN-ncnn-vulkan"
SHA="731633e6ac3d4e48476b64f2f77a006148913d25"
SRC_URI="https://github.com/Tatsh/VapourSynth-Real-ESRGAN-ncnn-vulkan/archive/${SHA}.tar.gz -> ${PN}-${SHA:0:7}.tar.gz
	https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/realesrgan-ncnn-vulkan-models.tar.xz"
S="${WORKDIR}/VapourSynth-Real-ESRGAN-ncnn-vulkan-${SHA}/src"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		"-DVAPOURSYNTH_INCLUDE_DIR=${EPREFIX}/usr/include/vapoursynth"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	insinto /usr/lib64/vapoursynth/models
	doins "${WORKDIR}/models/"*
}
