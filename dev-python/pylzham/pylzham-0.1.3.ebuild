# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python 3 wrapper for the LZHAM codec."
HOMEPAGE="https://github.com/Galaxy1036/pylzham https://pypi.org/project/pylzham/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
