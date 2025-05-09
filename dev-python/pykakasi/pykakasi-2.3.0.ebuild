# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2,3} )

inherit distutils-r1 pypi

DESCRIPTION="Transliterate Japanese to Romaji."
HOMEPAGE="https://pypi.org/project/pykakasi/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/jaconv[${PYTHON_USEDEP}]
	!app-i18n/kakasi"
BDEPEND="test? (
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	dev-python/pytest-benchmark[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
