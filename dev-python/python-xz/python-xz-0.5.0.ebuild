# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_1{0,1,2,3} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Pure Python implementation of the XZ file format with random access support."
HOMEPAGE="https://pypi.org/project/python-xz/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

S="${WORKDIR}/${P}"

src_prepare() {
	sed -re '/.*--cov/d' -i pytest.ini || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
