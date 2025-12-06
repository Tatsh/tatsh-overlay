# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A simple immutable dictionary."
HOMEPAGE="https://github.com/Marco-Sulla/python-frozendict"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
