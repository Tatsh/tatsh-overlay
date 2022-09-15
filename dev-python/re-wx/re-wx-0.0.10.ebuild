# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION="A library for building modern declarative desktop applications in WX."
HOMEPAGE="https://pypi.org/project/re-wx/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/wxpython-4.1.0[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/mypy_extensions[${PYTHON_USEDEP}]"

python_prepare_all() {
	rm -R tests || die
	sed  -re "/.*data_files=\[\('rewx'.*/d" -i setup.py || die
	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
