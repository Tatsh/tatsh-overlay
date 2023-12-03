# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=pdm
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1

DESCRIPTION="A lossless video/GIF/image upscaler."
HOMEPAGE="https://video2x.org/ https://github.com/k4yt3x/video2x"
MY_PV="${PV//_/-}"
SRC_URI="https://github.com/k4yt3x/${PN}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls"

RDEPEND="${PYTHON_DEPS}
	dev-python/ffmpeg-python[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pynput[${PYTHON_USEDEP}]
	dev-python/realcugan-ncnn-vulkan-python[${PYTHON_USEDEP}]
	dev-python/realsr-ncnn-vulkan-python[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/rife-ncnn-vulkan-python[${PYTHON_USEDEP}]
	dev-python/srmd-ncnn-vulkan-python[${PYTHON_USEDEP}]
	dev-python/waifu2x-ncnn-vulkan-python[${PYTHON_USEDEP}]
	media-libs/opencv[ffmpeg,${PYTHON_USEDEP}]
"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	sed -re '/^license-expression.*/d' -i pyproject.toml || die
	sed -re 's/^from cv2.*/import cv2/' -i "${PN}/${PN}.py" || die
	echo 'from .__main__ import main' >> "${PN}/__init__.py" || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
