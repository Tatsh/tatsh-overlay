# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
inherit cuda distutils-r1 multiprocessing pypi

DESCRIPTION="Flash Attention: Fast and Memory-Efficient Exact Attention (Python component)"
HOMEPAGE="https://github.com/Dao-AILab/flash-attention"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda rocm"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		sci-ml/einops[${PYTHON_USEDEP}]
	')
	>=sci-ml/pytorch-2.13.0[${PYTHON_SINGLE_USEDEP},cuda?,rocm?]
	cuda? ( >=sci-ml/pytorch-2.13.0[flash] )"
DEPEND="dev-libs/cutlass ${RDEPEND}"
# shellcheck disable=SC2016
BDEPEND="${PYTHON_DEPS}
	dev-build/ninja
	$(python_gen_cond_dep '
		dev-python/psutil[${PYTHON_USEDEP}]
		test? ( sci-ml/triton-bin[${PYTHON_USEDEP}] )
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
	# PyTorch >= 2.14 headers require C++20 (torch/all.h #errors otherwise, and
	# c10/util/intrusive_ptr.h uses operator<=>/std::strong_ordering). Must run
	# after PATCHES, whose context lines still say c++17.
	sed -i 's/c++17/c++20/g' setup.py || die
}

src_compile() {
	export FLASH_ATTENTION_FORCE_BUILD=TRUE "MAX_JOBS=$(makeopts_jobs)"
	if use cuda; then
		cuda_add_sandbox
		# nvcc only supports a limited range of host compilers, and torch's
		# extension builder refuses to run when the default one is too new.
		local cuda_bindir
		cuda_bindir="$(cuda_gccdir)" || die "cuda_gccdir failed"
		export CUDAHOSTCXX="${cuda_bindir}/g++"
		export NVCC_CCBIN="${CUDAHOSTCXX}"
		export CC="${cuda_bindir}/gcc" CXX="${CUDAHOSTCXX}"
		export BUILD_TARGET=cuda
	fi
	use rocm && export BUILD_TARGET=rocm
	distutils-r1_src_compile
}

src_test() {
	# The tests run on the GPU.
	local dev
	for dev in /dev/nvidia* /dev/kfd /dev/dri; do
		[[ -e ${dev} ]] && addwrite "${dev}"
	done
	addpredict /dev/char
	addwrite /proc/self/task
	local EPYTEST_IGNORE=(
		# ROCm backends.
		tests/test_flash_attn_ck.py
		tests/test_flash_attn_triton_amd.py
	)
	local EPYTEST_DESELECT=(
		# Uses JITFunction.cache_hook, which Triton 3.8 removed.
		tests/test_rotary.py::test_compilation_count
	)
	# Many cases are sized for 80 GB GPUs; report out-of-memory as a skip.
	mkdir -p "${T}/pytest-plugins" || die
	cp "${FILESDIR}/${PN}-oom-skip.py" "${T}/pytest-plugins/flash_attn_oom_skip.py" || die
	local -x PYTHONPATH="${T}/pytest-plugins${PYTHONPATH:+:${PYTHONPATH}}"
	# Only tests/; without a path pytest also collects csrc/cutlass's scripts.
	local EPYTEST_FLAGS="-p flash_attn_oom_skip tests"
	# The installed package, not the source tree, has the built extension.
	mv flash_attn flash_attn.src || die
	distutils-r1_src_test
	mv flash_attn.src flash_attn || die
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
