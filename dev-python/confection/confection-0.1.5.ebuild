# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="The sweetest config system for Python."
HOMEPAGE="https://github.com/explosion/confection"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!=dev-python/pydantic-1.8.1[${PYTHON_USEDEP}]
	!=dev-python/pydantic-1.8[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	<dev-python/srsly-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/srsly-2.4.0[${PYTHON_USEDEP}]"
