# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Setuptools extension to build and package CMake projects."
HOMEPAGE="https://pypi.org/project/cmake-build-extension/"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-util/cmake"

S="${WORKDIR}/${P}"

distutils_enable_tests pytest
