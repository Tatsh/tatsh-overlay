# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Clean single-source support for Python 3 and 2."
HOMEPAGE="https://python-future.org https://github.com/PythonCharmers/python-future https://pypi.org/project/future/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# The test suite imports imp, which was removed in Python 3.12.
RESTRICT="test"
