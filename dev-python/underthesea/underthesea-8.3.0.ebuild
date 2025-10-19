# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Vietnamese NLP Toolkit."
HOMEPAGE="https://pypi.org/project/underthesea/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="$(python_gen_cond_dep '
		>=dev-python/click-6.0[${PYTHON_USEDEP}]
		dev-python/joblib[${PYTHON_USEDEP}]
		>=dev-python/nltk-3.8[${PYTHON_USEDEP}]
		>=dev-python/python-crfsuite-0.9.6[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		>=dev-python/scikit-learn-1.6.1[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		dev-python/underthesea-core[${PYTHON_USEDEP}]
	')
	sci-ml/huggingface_hub[${PYTHON_SINGLE_USEDEP}]"
