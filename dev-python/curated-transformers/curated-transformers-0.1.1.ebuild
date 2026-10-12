# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Curated transformer models"
HOMEPAGE="https://github.com/explosion/curated-transformers"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=sci-ml/pytorch-1.12.0[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
