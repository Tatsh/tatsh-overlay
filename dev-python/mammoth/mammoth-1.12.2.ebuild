# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Convert Word documents (.docx files) to HTML."
HOMEPAGE="https://github.com/mwilliamson/python-mammoth https://pypi.org/project/mammoth/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/cobble-0.2[${PYTHON_USEDEP}]
	>=dev-python/cobble-0.1.3[${PYTHON_USEDEP}]
"

# The sdist ships tests/testing.py, a helper module, but none of the test
# modules that use it.
