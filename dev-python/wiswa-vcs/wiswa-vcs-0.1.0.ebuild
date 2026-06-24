# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Cross-host VCS metadata sync and mirroring helpers used by Wiswa."
HOMEPAGE="
	https://github.com/Tatsh/wiswa-vcs
	https://pypi.org/project/wiswa-vcs/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.3[${PYTHON_USEDEP}]
	>=dev-python/gidgethub-5.4.0[${PYTHON_USEDEP}]
	>=dev-python/gidgetlab-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.8[${PYTHON_USEDEP}]
	>=dev-python/packaging-26.2[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/wiswa-typing-0.0.1[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-cov[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest
