# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Functions and utils related to VapourSynth."
HOMEPAGE="https://pypi.org/project/vsexprtools/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/rich[${PYTHON_USEDEP}]
	media-libs/vstools[${PYTHON_USEDEP}]
	media-video/vapoursynth[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P^}"

distutils_enable_tests pytest

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	touch requirements.txt
	distutils-r1_src_prepare
}
