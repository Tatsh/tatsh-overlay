# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_1{0..4} )

inherit distutils-r1 pypi

DESCRIPTION="Library for advanced natural language processing."
HOMEPAGE="https://pypi.org/project/spacy/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="<dev-python/spacy-legacy-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/spacy-legacy-3.0.11[${PYTHON_USEDEP}]
	<dev-python/spacy-loggers-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/spacy-loggers-1.0.0[${PYTHON_USEDEP}]
	<dev-python/murmurhash-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/murmurhash-0.28.0[${PYTHON_USEDEP}]
	<dev-python/cymem-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/cymem-2.0.2[${PYTHON_USEDEP}]
	<dev-python/preshed-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/preshed-3.0.2[${PYTHON_USEDEP}]
	<dev-python/thinc-8.4.0[${PYTHON_USEDEP}]
	>=dev-python/thinc-8.3.4[${PYTHON_USEDEP}]
	<dev-python/wasabi-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/wasabi-0.9.1[${PYTHON_USEDEP}]
	<dev-python/srsly-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/srsly-2.4.3[${PYTHON_USEDEP}]
	<dev-python/catalogue-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/catalogue-2.0.6[${PYTHON_USEDEP}]
	<dev-python/weasel-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/weasel-0.1.0[${PYTHON_USEDEP}]
	<dev-python/typer-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/typer-0.3.0[${PYTHON_USEDEP}]
	<dev-python/tqdm-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.38.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19.0[${PYTHON_USEDEP}]
	<dev-python/requests-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.13.0[${PYTHON_USEDEP}]
	<dev-python/pydantic-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.7.4[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	<dev-python/langcodes-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/langcodes-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-20.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
