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

RDEPEND="dev-python/spacy-legacy[${PYTHON_USEDEP}]
	dev-python/spacy-loggers[${PYTHON_USEDEP}]
	dev-python/murmurhash[${PYTHON_USEDEP}]
	dev-python/cymem[${PYTHON_USEDEP}]
	dev-python/preshred[${PYTHON_USEDEP}]
	dev-python/thinc[${PYTHON_USEDEP}]
	dev-python/wasabi[${PYTHON_USEDEP}]
	dev-python/srsly[${PYTHON_USEDEP}]
	dev-python/catalogue[${PYTHON_USEDEP}]
	dev-python/weasel[${PYTHON_USEDEP}]
	dev-python/typer-slim[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
