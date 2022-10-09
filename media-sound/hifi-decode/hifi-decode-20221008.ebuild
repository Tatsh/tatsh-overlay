# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1

DESCRIPTION="Software defined VHS HiFi decoder."
HOMEPAGE="https://github.com/VideoMem/ld-decode/tree/hifi-decode"
SHA="237681edd896f0fd29ce84375d78641789125ab7"
SRC_URI="https://github.com/VideoMem/ld-decode/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sci-libs/fftw"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	media-video/ffmpeg
	media-video/vhs-decode[${PYTHON_USEDEP}]
	dev-python/pyhht[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/samplerate[${PYTHON_USEDEP}]
	<dev-python/soundfile-0.11.0
	dev-python/matplotlib"
BDEPEND="dev-python/cython:0[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}-0001-no-conflicts.patch" )

S="${WORKDIR}/ld-decode-${SHA}"

src_prepare() {
	distutils-r1_src_prepare
	mv vhsdecode hifidecode || die
}
