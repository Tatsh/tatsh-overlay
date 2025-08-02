# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( pypy3 python3_1{0,1,2,3} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1

EGIT_REPO_URI="https://gitlab.com/dslackw/${PN}"

DESCRIPTION="Very simple Python library for color and formatting in terminal"
HOMEPAGE="https://gitlab.com/dslackw/colored"
SRC_URI="https://gitlab.com/dslackw/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

python_test() {
	"${EPYTHON}" tests/test_hex_1.py || die
	"${EPYTHON}" tests/test_hex_2.py || die
}
