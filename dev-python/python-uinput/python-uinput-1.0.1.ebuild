# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
# The sdist predates PyPI name normalization and still uses a hyphen.
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Pythonic API to the Linux uinput kernel module."
HOMEPAGE="https://github.com/pyinput/python-uinput https://pypi.org/project/python-uinput/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

# The _libsuinput extension links against libudev.
DEPEND="virtual/libudev:="
RDEPEND="${DEPEND}"
