# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="FSRCNN ported to VapourSynth."
HOMEPAGE="https://github.com/Sg4Dylan/vapoursynth-fsrcnn-ncnn-vulkan"
SHA="0a721959116f6f86dbd13bda70a5fd6a883938f4"
SRC_URI="https://github.com/Sg4Dylan/vapoursynth-fsrcnn-ncnn-vulkan/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/ncnn
	media-libs/vulkan-loader
	media-libs/opencv"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-0001-linux-support.patch" )

S="${WORKDIR}/${PN}-${SHA}"
