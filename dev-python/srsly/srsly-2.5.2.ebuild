# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="Modern high-performance serialization utilities for Python."
HOMEPAGE="https://github.com/explosion/srsly"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/catalogue-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/catalogue-2.0.3[${PYTHON_USEDEP}]"
