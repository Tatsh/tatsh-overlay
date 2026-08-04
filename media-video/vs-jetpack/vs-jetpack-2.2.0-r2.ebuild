# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling

PYPI_VERIFY_REPO="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack"

inherit distutils-r1 pypi

DESCRIPTION="Full suite of filters, wrappers, etc for filtering video using VapourSynth."
HOMEPAGE="https://github.com/Jaded-Encoding-Thaumaturgy/vs-jetpack"
SRC_URI="$(pypi_sdist_url vsjetpack)"
S="${WORKDIR}/vsjetpack-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="media-video/vapoursynth[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/jetpytools[${PYTHON_USEDEP}]
		>=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
	')"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
