# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1} )

inherit distutils-r1

DESCRIPTION="Remove backgrounds from images and video using AI."
HOMEPAGE="https://github.com/nadermx/backgroundremover"
SRC_URI="https://github.com/nadermx/backgroundremover/archive/refs/tags/v0.2.8.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep 'dev-python/PySocks[${PYTHON_USEDEP}]
		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/ffmpeg-python[${PYTHON_USEDEP}]
		dev-python/filetype[${PYTHON_USEDEP}]
		dev-python/hsh[${PYTHON_USEDEP}]
		dev-python/idna[${PYTHON_USEDEP}]
		dev-python/more-itertools[${PYTHON_USEDEP}]
		dev-python/moviepy[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pymatting[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
		dev-python/waitress[${PYTHON_USEDEP}]')
	sci-libs/torchvision[${PYTHON_SINGLE_USEDEP}]
	sci-libs/pytorch[${PYTHON_SINGLE_USEDEP}]
	${PYTHON_DEPS}"
