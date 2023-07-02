# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="VapourSynth denoising, regression, and motion compensation functions"
HOMEPAGE="https://github.com/Irrational-Encoding-Wizardry/vs-denoise"
SHA="a54089207a5a42cabbc6eebc1c3d753f31faf995"
SRC_URI="https://github.com/Irrational-Encoding-Wizardry/vs-denoise/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/vapoursynth[${PYTHON_USEDEP}]
	media-libs/vsaa[${PYTHON_USEDEP}]
	media-libs/vsexprtools[${PYTHON_USEDEP}]
	media-libs/vskernels[${PYTHON_USEDEP}]
	media-libs/vsmasktools[${PYTHON_USEDEP}]
	media-libs/vsrgtools[${PYTHON_USEDEP}]
	media-libs/vsscale[${PYTHON_USEDEP}]
	media-libs/vstools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${SHA}"
