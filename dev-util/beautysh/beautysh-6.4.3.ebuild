# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
EPYTEST_PLUGINS=( hypothesis )
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 pypi

DESCRIPTION="A Bash beautifier for the masses."
HOMEPAGE="https://github.com/lovesegfault/beautysh https://pypi.org/project/beautysh/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/colorama-0.4.4[${PYTHON_USEDEP}]
	>=dev-python/editorconfig-0.12.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
