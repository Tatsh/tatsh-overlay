# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest snapshot test utility"
HOMEPAGE="
	https://github.com/syrupy-project/syrupy
	https://pypi.org/project/syrupy/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pytest-8.0.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
