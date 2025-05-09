# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 pypi

DESCRIPTION="A collection of general purpose Vapoursynth functions"
HOMEPAGE="https://pypi.org/project/vsutil/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/vapoursynth[${PYTHON_USEDEP}]"
