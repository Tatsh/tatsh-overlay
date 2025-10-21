# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit cuda distutils-r1 pypi

DESCRIPTION="Flash Attention: Fast and Memory-Efficient Exact Attention (Python component)."
HOMEPAGE="https://github.com/Dao-AILab/flash-attention"
IUSE="cuda rocm"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-libs/cutlass"
# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		sci-ml/einops[${PYTHON_USEDEP}]
	')
	cuda? ( sci-ml/caffe2[cuda,flash] )
	rocm? ( sci-ml/caffe2[rocm] )
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
# shellcheck disable=SC2016
BDEPEND="${PYTHON_DEPS}
	dev-build/ninja
	$(python_gen_cond_dep '
		dev-python/psutil[${PYTHON_USEDEP}]
	')"

PATCHES=(
	"${FILESDIR}/${PN}-respect-flags.patch"
)

pkg_setup() {
	if use cuda; then
		if [[ -z "${NVCC_PREPEND_FLAGS}" ]] || ! grep -q -- "--threads" <<< "${NVCC_PREPEND_FLAGS}"; then
			ewarn
			ewarn "If this hangs your system, try adding '--threads 1' to NVCC_PREPEND_FLAGS. Or try"
			ewarn "lowering the number of make jobs. Example:"
			ewarn
			ewarn "  mkdir -p /etc/portage/env /etc/portage/package.env"
			ewarn "  echo 'NVCC_PREPEND_FLAGS=\"--threads 1\"' > /etc/portage/env/flash-attn"
			ewarn "  echo 'sci-ml/flash-attn flash-attn' >> /etc/portage/package.env/flash-attn"
			ewarn
		fi
	fi
	python-single-r1_pkg_setup
}

src_prepare() {
	cuda_src_prepare
	distutils-r1_src_prepare
}

src_compile() {
	export FLASH_ATTENTION_FORCE_BUILD=TRUE "MAX_JOBS=$(makeopts_jobs)"
	if use cuda; then
		cuda_add_sandbox
		export BUILD_TARGET=cuda
	fi
	use rocm && export BUILD_TARGET=rocm
	distutils-r1_src_compile
}
