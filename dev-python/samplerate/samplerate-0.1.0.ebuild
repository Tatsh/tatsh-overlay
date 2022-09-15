# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION=""
HOMEPAGE="https://pypi.org/project/samplerate/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/libsamplerate
	virtual/python-cffi[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
