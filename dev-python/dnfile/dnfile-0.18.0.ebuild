# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1,2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="Parse .NET executable files."
HOMEPAGE="https://pypi.org/project/dnfile/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pefile-2019.4.18[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
