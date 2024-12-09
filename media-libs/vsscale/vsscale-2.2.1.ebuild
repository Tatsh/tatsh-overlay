# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Wrappers for scaling and descaling functions."
HOMEPAGE="https://pypi.org/project/vsscale/"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/vstools[${PYTHON_USEDEP}]
	media-libs/vsexprtools[${PYTHON_USEDEP}]
	media-libs/vskernels[${PYTHON_USEDEP}]
	media-libs/vsrgtools[${PYTHON_USEDEP}]
	media-libs/vsmasktools[${PYTHON_USEDEP}]
	media-libs/vsaa[${PYTHON_USEDEP}]
	media-video/vapoursynth[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P^}"

distutils_enable_tests pytest

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	touch requirements.txt
	distutils-r1_src_prepare
}
