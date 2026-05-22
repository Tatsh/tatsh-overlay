# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="An async GitHub API library"
HOMEPAGE="
	https://github.com/brettcannon/gidgethub
	https://pypi.org/project/gidgethub/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# pyjwt[crypto] extra pulls in cryptography; ::gentoo's pyjwt has no
# USE=crypto flag so we depend on cryptography directly.
RDEPEND=">=dev-python/cryptography-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/uritemplate-3.0.1[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
