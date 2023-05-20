# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SRMD super resolution plugin for VapourSynth"
HOMEPAGE="https://github.com/Kiyamou/VapourSynth-SRMD-ncnn-Vulkan"
SRC_URI="https://github.com/Kiyamou/VapourSynth-SRMD-ncnn-Vulkan/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0001-system-deps.patch" )

S="${WORKDIR}/VapourSynth-SRMD-ncnn-Vulkan-r${PV}"

src_configure() {
	local mycmakeargs=(
		"-DVAPOURSYNTH_INCLUDE_DIR=${EPREFIX}/usr/include/vapoursynth"
	)
	cmake_src_configure
}
