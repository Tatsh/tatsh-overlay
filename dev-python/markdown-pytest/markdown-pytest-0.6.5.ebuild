# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for running tests directly from Markdown files"
HOMEPAGE="
	https://github.com/mosquito/markdown-pytest
	https://pypi.org/project/markdown-pytest/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
