# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="VapourSynth functions and helpers for writing RPN expressions."
HOMEPAGE="https://pypi.org/project/vsexprtools/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/vstools[${PYTHON_USEDEP}]
	media-video/vapoursynth[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	touch requirements.txt
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
