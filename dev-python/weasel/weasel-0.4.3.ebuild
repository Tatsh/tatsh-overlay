# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A small and easy workflow system."
HOMEPAGE="https://github.com/explosion/weasel"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/cloudpathlib-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/cloudpathlib-0.7.0[${PYTHON_USEDEP}]
	<dev-python/confection-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/confection-0.0.4[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.13.0[${PYTHON_USEDEP}]
	<dev-python/smart-open-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/smart-open-5.2.1[${PYTHON_USEDEP}]
	<dev-python/srsly-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/srsly-2.4.3[${PYTHON_USEDEP}]
	<dev-python/typer-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/typer-0.3.0[${PYTHON_USEDEP}]
	<dev-python/wasabi-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/wasabi-0.9.1[${PYTHON_USEDEP}]"
