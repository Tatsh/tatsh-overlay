# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Flash Attention: Fast and Memory-Efficient Exact Attention."
HOMEPAGE="https://github.com/Dao-AILab/flash-attention"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		sci-ml/einops[${PYTHON_USEDEP}]
	')
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"
