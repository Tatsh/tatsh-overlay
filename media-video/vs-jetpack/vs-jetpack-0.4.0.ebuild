# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Full suite of filters, wrappers, and helper functions for filtering video using VapourSynth."
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack"
SRC_URI="https://github.com/Jaded-Encoding-Thaumaturgy/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/jetpytools[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	media-video/vapoursynth[${PYTHON_USEDEP},vspipe]"

distutils_enable_tests pytest
