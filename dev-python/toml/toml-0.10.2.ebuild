# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for TOML."
HOMEPAGE="https://pypi.org/project/toml/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? (
	dev-python/pytest-cov[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
