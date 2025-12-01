# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )
inherit distutils-r1 pypi

DESCRIPTION="Turn any command line program into a full GUI application with one line."
HOMEPAGE="https://pypi.org/project/gooey/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN^}")"
S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

MY_PN="G${PN:1}"

RDEPEND=">=dev-python/wxpython-4.1.1-r2[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/psutil:0[${PYTHON_USEDEP}]
	dev-python/colored[${PYTHON_USEDEP}]
	dev-python/pygtrie[${PYTHON_USEDEP}]
	dev-python/re-wx[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/mypy-extensions[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
