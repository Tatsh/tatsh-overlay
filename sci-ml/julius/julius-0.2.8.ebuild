# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="DSP utilities for PyTorch: resampling, FFT convolutions and filter banks."
HOMEPAGE="https://pypi.org/project/julius/ https://github.com/adefossez/julius"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# shellcheck disable=SC2016
BDEPEND="test? (
	$(python_gen_cond_dep '
		>=dev-python/resampy-0.4.3[${PYTHON_USEDEP}]
	')
)"
RDEPEND="${PYTHON_DEPS}
	>=sci-ml/pytorch-1.13.0[${PYTHON_SINGLE_USEDEP}]"

# Nothing here needs a pytest plugin, so do not autoload the ones that happen to
# be installed. This is the EAPI 9 default.
EPYTEST_PLUGINS=()

distutils_enable_tests pytest
