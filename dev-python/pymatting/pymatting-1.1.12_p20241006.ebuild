# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="A Python library for alpha matting."
HOMEPAGE="https://pypi.org/project/PyMatting/"
SHA="30b844ff437440b28e168f6e444297f2005aeb5b"
SRC_URI="https://github.com/${PN}/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/numba[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${SHA}"

distutils_enable_tests pytest
