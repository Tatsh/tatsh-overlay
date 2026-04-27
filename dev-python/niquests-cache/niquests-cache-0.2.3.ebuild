# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Cached niquests sessions with pluggable storage backends"
HOMEPAGE="
	https://tatsh.github.io/niquests-cache/
	https://github.com/Tatsh/niquests-cache
	https://pypi.org/project/niquests-cache/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/aiosqlite-0.22.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.6[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
