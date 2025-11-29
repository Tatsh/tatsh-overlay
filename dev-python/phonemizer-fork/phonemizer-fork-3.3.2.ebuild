# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0..3} )

inherit distutils-r1 pypi

DESCRIPTION="Simple text to phones converter for multiple languages."
HOMEPAGE="https://pypi.org/project/phonemizer-fork/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/joblib[${PYTHON_USEDEP}]
	dev-python/segments[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/dlinfo[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
