# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Pure-Python Japanese character interconverter."
HOMEPAGE="https://pypi.org/project/jaconv/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	sed -re '/.*data_files=.*/d' -i setup.py || die
	distutils-r1_src_prepare
}
