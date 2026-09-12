# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Create Python data objects."
HOMEPAGE="https://github.com/mwilliamson/python-cobble https://pypi.org/project/cobble/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

# The sdist ships neither tests.py nor test-requirements.txt.
