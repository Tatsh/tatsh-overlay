# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="pytest plugin to show failures instantly."
HOMEPAGE="https://github.com/pytest-dev/pytest-instafail https://pypi.org/project/pytest-instafail/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
