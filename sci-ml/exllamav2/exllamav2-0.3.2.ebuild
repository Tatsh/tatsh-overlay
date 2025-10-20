# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi python-single-r1

DESCRIPTION="Inference library for running local LLMs on consumer hardware."
HOMEPAGE="https://github.com/turboderp/exllamav2"
SRC_URI="https://github.com/turboderp-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/fastparquet[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		>=sci-ml/safetensors-0.3.2[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]
	')
	>=sci-ml/pytorch-2.2.0[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	dev-build/ninja"
