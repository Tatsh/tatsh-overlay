# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Music source separation in the waveform domain."
HOMEPAGE="https://pypi.org/project/demucs/ https://github.com/adefossez/demucs"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# The only test is tools/test_pretrained.py, which evaluates against the MusDB
# dataset it downloads, and needs the unpackaged train extras to import at all.
RESTRICT="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/lameenc-1.2[${PYTHON_USEDEP}]
		>=dev-python/sphn-0.1.12[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		sci-ml/einops[${PYTHON_USEDEP}]
		sci-ml/safetensors[${PYTHON_USEDEP}]
	')
	>=sci-ml/julius-0.2.3[${PYTHON_SINGLE_USEDEP}]
	>=sci-ml/pytorch-2.1[${PYTHON_SINGLE_USEDEP}]
	sci-ml/huggingface_hub[${PYTHON_SINGLE_USEDEP}]"

pkg_postinst() {
	elog "Training needs the extras upstream calls 'train' (dora-search, hydra, musdb,"
	elog "museval, submitit, treetable), none of which are packaged. Separating tracks with"
	elog "the pretrained models works without them."
}
