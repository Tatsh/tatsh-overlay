# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Inference library for running local LLMs on consumer hardware"
HOMEPAGE="https://github.com/turboderp-org/exllamav3"
SRC_URI="https://github.com/turboderp-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/llguidance-1.7.0[${PYTHON_USEDEP}]
		dev-python/marisa-trie[${PYTHON_USEDEP}]
		>=dev-python/numpy-2.1.0[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/rich[${PYTHON_USEDEP}]
		>=sci-ml/safetensors-0.3.2[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		sci-ml/triton-bin[${PYTHON_USEDEP}]
	')
	>=sci-ml/pytorch-2.13.0[flash,${PYTHON_SINGLE_USEDEP}]
	sci-ml/flash-attn[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/tokenizers-0.21.1[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}
	dev-build/ninja
	|| (
		sys-devel/gcc:13
		sys-devel/gcc:15
	)"

src_configure() {
	# Prefer GCC 13; GCC 15 is the slot that is stable on every profile.
	local slot
	for slot in 13 15; do
		if has_version -b "sys-devel/gcc:${slot}"; then
			export CC="${CHOST}-gcc-${slot}" CXX="${CHOST}-g++-${slot}"
			break
		fi
	done
	distutils-r1_src_configure
}

src_test() {
	# CUDA. Tests that need model weights skip themselves without a registry.
	local dev
	for dev in /dev/nvidia*; do
		[[ -e ${dev} ]] && addwrite "${dev}"
	done
	addpredict /dev/char
	addwrite /proc/self/task
	# conftest.py puts the source tree first on sys.path; move it so the built
	# extension is imported instead of being JIT-compiled.
	local EPYTEST_DESELECT=(
		# These build modules with object.__new__() or hand-written stubs that
		# lack attributes the 1.6.6 classes now set in __init__ (kda_direct,
		# sparse_head, recurrent_state_cls, config, device).
		tests/conversion/test_optimizer_targets.py::test_split_gdn_level3_measures_inputs_and_output_once
		tests/conversion/test_optimizer_targets.py::test_split_gdn_level2_keeps_output_in_combined_group
		tests/conversion/test_optimizer_targets.py::test_qwen38_optimizer_topology_has_expected_unique_groups_and_linears
		tests/modules/draft/test_dflash2.py::test_prepare_inputs_sets_anchor_and_uses_dflash_attention_setup
		tests/modules/draft/test_dflash2.py::test_tp_target_is_rejected_during_attach
		tests/modules/draft/test_dflash2.py::test_candidate_logit_scale_and_softcap_are_applied
		tests/modules/draft/test_dflash2.py::test_sample_exports_selector_confidence_for_dynamic_drafting
		tests/moe_cpu/test_split_defer_guard.py::test_permuted_split_loads_router_gate_eagerly
		tests/moe_cpu/test_swap_sweep_inference_mode.py::test_queue_drained_hook_enters_inference_mode
	)
	mv exllamav3 exllamav3.src || die
	distutils-r1_src_test
	mv exllamav3.src exllamav3 || die
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
