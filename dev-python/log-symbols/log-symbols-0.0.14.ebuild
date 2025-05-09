# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1 pypi

DESCRIPTION="Colored symbols for various log levels for Python."
HOMEPAGE="https://pypi.org/project/log-symbols/ https://github.com/manrajgrover/py-log-symbols"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]"
