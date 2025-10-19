# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_1{0..3} )

inherit distutils-r1 pypi

DESCRIPTION="An inference library for Kokoro-82M."
HOMEPAGE="https://pypi.org/project/kokoro/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '
		dev-python/loguru[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	')
	dev-python/misaki[l10n_en,${PYTHON_SINGLE_USEDEP}]
  sci-ml/huggingface_hub[${PYTHON_SINGLE_USEDEP}]
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]
	sci-ml/transformers[${PYTHON_SINGLE_USEDEP}]"

distutils_enable_tests pytest
