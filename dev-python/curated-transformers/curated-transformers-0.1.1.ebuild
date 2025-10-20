# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi python-single-r1

DESCRIPTION="Curated transformer models."
HOMEPAGE="https://github.com/explosion/curated-transformers"
SRC_URI="$(pypi_sdist_url --no-normalize "${PN}")"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${PN}-${PV}"
