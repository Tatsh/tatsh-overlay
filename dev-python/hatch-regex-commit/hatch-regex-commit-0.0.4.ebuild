# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Hatch plugin to create a commit and tag when bumping version"
HOMEPAGE="
	https://github.com/frankie567/hatch-regex-commit
	https://pypi.org/project/hatch-regex-commit/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/hatchling[${PYTHON_USEDEP}]"
