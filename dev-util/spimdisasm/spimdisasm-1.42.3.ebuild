# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1,2,3,4,5} )

PYPI_VERIFY_REPO="https://github.com/Decompollaborate/spimdisasm"

inherit distutils-r1 pypi

DESCRIPTION="MIPS disassembler."
HOMEPAGE="https://pypi.org/project/spimdisasm/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/rabbitizer[${PYTHON_USEDEP}]"
