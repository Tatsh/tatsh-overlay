# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )
PYPI_NO_NORMALIZE=1

inherit distutils-r1 pypi

DESCRIPTION="Creates JSON report compatible with atom.io's linter message format"
HOMEPAGE="
	https://github.com/wandel/pytest-atom
	https://pypi.org/project/pytest-report/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
