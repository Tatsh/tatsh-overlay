# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Detect file content types with a deep learning model."
HOMEPAGE="https://google.github.io/magika/ https://github.com/google/magika
	https://pypi.org/project/magika/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# shellcheck disable=SC2016
RDEPEND="
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0.1[${PYTHON_USEDEP}]
	>=sci-libs/onnxruntime-1.17.0
	$(python_gen_cond_dep '
		>=dev-python/numpy-1.26[${PYTHON_USEDEP}]
	' python3_1{0,1})
	$(python_gen_cond_dep '
		>=dev-python/numpy-2.1.0[${PYTHON_USEDEP}]
	' python3_1{2,3,4,5})
"

distutils_enable_tests pytest
