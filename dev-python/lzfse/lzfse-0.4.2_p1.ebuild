# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/m1stadev/lzfse
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the LZFSE reference implementation"
HOMEPAGE="https://github.com/m1stadev/lzfse https://pypi.org/project/lzfse/"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64"
