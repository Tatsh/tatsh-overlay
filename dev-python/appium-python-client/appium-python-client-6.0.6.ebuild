# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python client for Appium."
HOMEPAGE="https://appium.io/ https://github.com/appium/python-client"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/selenium-4.37.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.16[${PYTHON_USEDEP}]
"

# Upstream excludes test/ from the sdist, so there is nothing to run here.
