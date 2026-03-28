# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=meson-python
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit distutils-r1 pypi

DESCRIPTION="Python bindings for libsamplerate."
HOMEPAGE="https://pypi.org/project/samplerate/ https://github.com/tuxu/python-samplerate"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libsamplerate
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/pybind11[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${PN}-meson.patch"
)

distutils_enable_tests pytest
