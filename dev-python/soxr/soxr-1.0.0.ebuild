# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=scikit-build-core
PYTHON_COMPAT=( python3_1{2,3,4} )

inherit distutils-r1 pypi

DESCRIPTION="High quality, one-dimensional sample-rate conversion library"
HOMEPAGE="https://pypi.org/project/soxr/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/soxr"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/nanobind[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
