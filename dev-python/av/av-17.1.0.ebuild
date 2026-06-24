# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_1{0..4} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic bindings for FFmpeg's libraries."
HOMEPAGE="https://pypi.org/project/av/ https://github.com/PyAV-Org/PyAV/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg:="
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
