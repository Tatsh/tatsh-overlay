# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Curated transformer models for spaCy pipelines."
HOMEPAGE="https://github.com/explosion/spacy-curated-transformers"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '
		<dev-python/curated-tokenizers-0.1.0[${PYTHON_USEDEP}]
		>=dev-python/curated-tokenizers-0.0.9[${PYTHON_USEDEP}]
		<dev-python/thinc-9.1.0[${PYTHON_USEDEP}]
		>=dev-python/thinc-8.1.6[${PYTHON_USEDEP}]
	')
  >=dev-python/curated-transformers-0.1.0[${PYTHON_SINGLE_USEDEP}]
  <dev-python/curated-transformers-0.2.0[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/pytorch-1.12.0[${PYTHON_SINGLE_USEDEP}]"
