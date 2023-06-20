# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Waifu2x filter for VapourSynth"
HOMEPAGE="https://github.com/nlzy/vapoursynth-waifu2x-ncnn-vulkan"
SRC_URI="https://github.com/nlzy/${PN}/archive/refs/tags/r${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nlzy/vapoursynth-waifu2x-ncnn-vulkan/releases/download/r0.1/models.7z -> ${P}-models.7z"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn media-libs/vulkan-loader"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/p7zip"

PATCHES=( "${FILESDIR}/${PN}-0001-system-deps.patch" )

S="${WORKDIR}/${PN}-r${PV}"

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

src_install() {
	cmake_src_install
	insinto "/usr/$(get_libdir)/vapoursynth"
	doins -r "${WORKDIR}/models"-{cunet,upconv_7_anime_style_art_rgb,upconv_7_photo}
}
