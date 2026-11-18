# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/doronz88/pmd-pytcp
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Network protocol packet parse and assemble layer of the PyTCP stack"
HOMEPAGE="https://github.com/doronz88/pmd-pytcp https://pypi.org/project/pmd-net-proto/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	~dev-python/pmd-net-addr-0.0.3[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6[${PYTHON_USEDEP}]
"
