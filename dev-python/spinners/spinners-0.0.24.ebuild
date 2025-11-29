# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="More than 60 spinners for terminal."
HOMEPAGE="https://pypi.org/project/spinners/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
