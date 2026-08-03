# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3,4,5} )

PYPI_VERIFY_REPO="https://github.com/wakepy/wakepy"

inherit distutils-r1 pypi

DESCRIPTION="Cross-platform wakelock / keep-awake / stay-awake written in Python."
HOMEPAGE="https://pypi.org/project/wakepy/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/jeepney-0.7.1[${PYTHON_USEDEP}]
"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
