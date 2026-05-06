# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for printing summary data as I want it"
HOMEPAGE="
	https://github.com/samuelcolvin/pytest-pretty
	https://pypi.org/project/pytest-pretty/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/pytest-7[${PYTHON_USEDEP}]
	>=dev-python/rich-12[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
