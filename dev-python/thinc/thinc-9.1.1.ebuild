# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Functional take on deep learning, compatible with your favorite libraries"
HOMEPAGE="https://github.com/explosion/thinc"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/blis-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/blis-1.0.0[${PYTHON_USEDEP}]
	<dev-python/catalogue-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/catalogue-2.0.4[${PYTHON_USEDEP}]
	<dev-python/confection-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/confection-0.0.1[${PYTHON_USEDEP}]
	<dev-python/cymem-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/cymem-2.0.2[${PYTHON_USEDEP}]
	<dev-python/murmurhash-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/murmurhash-1.0.2[${PYTHON_USEDEP}]
	<dev-python/numpy-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	<dev-python/preshed-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/preshed-3.0.2[${PYTHON_USEDEP}]
	!=dev-python/pydantic-1.8.1[${PYTHON_USEDEP}]
	!=dev-python/pydantic-1.8[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	<dev-python/srsly-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/srsly-2.4.0[${PYTHON_USEDEP}]
	<dev-python/wasabi-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/wasabi-0.8.1[${PYTHON_USEDEP}]"
