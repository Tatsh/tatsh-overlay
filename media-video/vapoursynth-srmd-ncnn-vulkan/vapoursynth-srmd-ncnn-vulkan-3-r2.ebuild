# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SRMD super resolution plugin for VapourSynth"
HOMEPAGE="https://github.com/Kiyamou/VapourSynth-SRMD-ncnn-Vulkan"
SRC_URI="https://github.com/Kiyamou/VapourSynth-SRMD-ncnn-Vulkan/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Kiyamou/VapourSynth-SRMD-ncnn-Vulkan/releases/download/r1/models.7z -> ${P}-models.7z"
S="${WORKDIR}/VapourSynth-SRMD-ncnn-Vulkan-r${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/7zip"

PATCHES=( "${FILESDIR}/${PN}-0001-system-deps.patch" )

src_unpack() {
	local archive
	for archive in ${A}; do
		case "${archive}" in
			*.7z)
			7z -bb0 -y -bd x "${DISTDIR}/${archive}"
			;;
			*)
			unpack "${archive}"
			;;
		esac
	done
}

src_configure() {
	local mycmakeargs=(
		"-DVAPOURSYNTH_INCLUDE_DIR=${EPREFIX}/usr/include/vapoursynth"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	insinto /usr/lib64/vapoursynth/models/models-srmd
	doins "${WORKDIR}/models-srmd/"*
}
