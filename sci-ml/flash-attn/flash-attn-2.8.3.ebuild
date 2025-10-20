# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
CUDA_VERBOSE=true

inherit cuda distutils-r1 pypi

DESCRIPTION="Flash Attention: Fast and Memory-Efficient Exact Attention (Python component)."
HOMEPAGE="https://github.com/Dao-AILab/flash-attention"
IUSE="cuda rocm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		sci-ml/einops[${PYTHON_USEDEP}]
	')
	cuda? ( sci-ml/caffe2[cuda,flash] )
	rocm? ( sci-ml/caffe2[rocm] )
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	dev-build/ninja"

src_compile() {
	use cuda && cuda_add_sandbox
	export FLASH_ATTENTION_FORCE_BUILD=TRUE \
		MAX_JOBS=$(makeopts_jobs) \
		NVCC_THREADS=1  # Stop machine from hanging.
	use cuda && export BUILD_TARGET=cuda
	use rocm && export BUILD_TARGET=rocm
	distutils-r1_src_compile
}
