# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )
inherit distutils-r1

DESCRIPTION="Turn (almost) any command line program into a full GUI application with one line."
HOMEPAGE="https://pypi.org/project/gooey/"
MY_PN="G${PN:1}"
SRC_URI="https://github.com/chriskiehl/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/wxpython-4.1.1
	dev-python/pillow
	dev-python/psutil:0
	dev-python/colored
	dev-python/pygtrie
	dev-python/re-wx
	dev-python/typing-extensions
	dev-python/mypy_extensions"

S="${WORKDIR}/${MY_PN}-${PV}"

distutils_enable_tests pytest
