# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

PYPI_VERIFY_REPO="https://github.com/dynaconf/dynaconf"

inherit distutils-r1 pypi

DESCRIPTION="The dynamic configurator for your Python Project."
HOMEPAGE="https://github.com/dynaconf/dynaconf https://pypi.org/project/dynaconf/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
