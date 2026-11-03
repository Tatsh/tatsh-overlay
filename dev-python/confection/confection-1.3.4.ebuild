# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..15} )
DISTUTILS_USE_PEP517=setuptools

PYPI_VERIFY_REPO="https://github.com/explosion/confection"

inherit distutils-r1 pypi

DESCRIPTION="The sweetest config system for Python"
HOMEPAGE="https://github.com/explosion/confection"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '
	>=dev-python/typing-extensions-4.0[${PYTHON_USEDEP}]
	<dev-python/typing-extensions-5[${PYTHON_USEDEP}]
' python3_10)"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
