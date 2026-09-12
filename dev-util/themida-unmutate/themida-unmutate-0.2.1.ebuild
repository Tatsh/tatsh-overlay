# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..15} )

inherit distutils-r1 pypi

DESCRIPTION="Static deobfuscator for Themida's mutation-based obfuscation."
HOMEPAGE="https://github.com/ergrelet/themida-unmutate https://pypi.org/project/themida-unmutate/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	<dev-python/lief-0.16.0[${PYTHON_USEDEP}]
	<dev-python/miasm-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/lief-0.15.1[${PYTHON_USEDEP}]
	>=dev-python/miasm-0.1.5[${PYTHON_USEDEP}]
"
