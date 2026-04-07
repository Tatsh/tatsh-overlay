# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Yet Another Terminal Spinner."
HOMEPAGE="https://github.com/pavdmyt/yaspin"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/termcolor-3.2[${PYTHON_USEDEP}]
	<dev-python/termcolor-4.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
