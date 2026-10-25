# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Feed generator for ATOM, RSS and Podcasts"
HOMEPAGE="https://github.com/lkiesow/python-feedgen https://pypi.org/project/feedgen/"
LICENSE="|| ( BSD-2 LGPL-3+ )"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
