# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Real-CUGAN super resolution plugin for VapourSynth."
HOMEPAGE="https://github.com/Kiyamou/VapourSynth-RealCUGAN-ncnn-Vulkan"
SRC_URI="https://github.com/Kiyamou/VapourSynth-RealCUGAN-ncnn-Vulkan/archive/refs/tags/r2.tar.gz -> ${P}.tar.gz
	https://github.com/Kiyamou/VapourSynth-RealCUGAN-ncnn-Vulkan/releases/download/r2/models.zip -> ${PN}-models-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

PATCHES=( "${FILESDIR}/${PN}-0001-system-deps.patch" )

S="${WORKDIR}/VapourSynth-RealCUGAN-ncnn-Vulkan-r${PV}"

src_configure() {
	local mycmakeargs=(
		"-DVAPOURSYNTH_INCLUDE_DIR=${EPREFIX}/usr/include/vapoursynth"
	)
	cmake_src_configure
}

src_install() {
	exeinto "/usr/$(get_libdir)/vapoursynth"
	doexe "${BUILD_DIR}/librealcugannv.so"
	insinto "/usr/$(get_libdir)/vapoursynth"
	doins -r "${WORKDIR}/models-"{nose,pro,se}
	einstalldocs
}
