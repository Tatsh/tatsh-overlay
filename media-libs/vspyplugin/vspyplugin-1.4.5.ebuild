# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Package for simplifying writing VapourSynth 'plugins' in python."
HOMEPAGE="https://pypi.org/project/vspyplugin/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"
S="${WORKDIR}/${PN}-${PV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/vs-jetpack[${PYTHON_USEDEP}]
	media-video/vapoursynth[${PYTHON_USEDEP}]"

src_prepare() {
	touch requirements.txt
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
