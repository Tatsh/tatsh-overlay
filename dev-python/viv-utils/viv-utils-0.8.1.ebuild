# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

PYTHON_COMPAT=( python3_1{2,3,4} )

inherit distutils-r1

DESCRIPTION="Utilities for Vivisect."
HOMEPAGE="https://github.com/williballenthin/viv-utils https://pypi.org/project/viv-utils/"
SRC_URI="https://github.com/williballenthin/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
# KEYWORDS="~amd64"

RDEPEND="
	dev-python/funcy[${PYTHON_USEDEP}]
	dev-python/intervaltree[${PYTHON_USEDEP}]
	dev-python/python-flirt[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-util/vivisect[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-sugar[${PYTHON_USEDEP}]
		dev-python/pytest-instafail[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
