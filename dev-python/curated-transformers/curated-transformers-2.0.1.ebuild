# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A PyTorch library of transformer models and components."
HOMEPAGE="https://github.com/explosion/curated-transformers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

	# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		<dev-python/catalogue-2.1.0[${PYTHON_USEDEP}]
		>=dev-python/catalogue-2.0.4[${PYTHON_USEDEP}]
		<dev-python/curated-tokenizers-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/curated-tokenizers-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/huggingface-hub-0.14[${PYTHON_USEDEP}]
		>=dev-python/tokenizers-0.13.3[${PYTHON_USEDEP}]
	')
	sci-libs/pytorch[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"
