# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/m1stadev/pylzss
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for decoding and encoding LZSS-compressed data"
HOMEPAGE="https://github.com/m1stadev/pylzss https://pypi.org/project/pylzss/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
