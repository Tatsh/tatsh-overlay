# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..15} )

inherit distutils-r1 pypi

DESCRIPTION="Ghidra binary diffing engine."
HOMEPAGE="https://github.com/clearbluejar/ghidriff https://pypi.org/project/ghidriff/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Upstream pins mdutils==1.6.0; nothing it uses changed since.
RDEPEND="
	>=dev-python/mdutils-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/pyghidra-2.0.0[${PYTHON_USEDEP}]
"

# The test suite is end to end: it starts a Ghidra JVM and needs binary and
# symbol fixtures that are not shipped in the sdist.
RESTRICT="test"
