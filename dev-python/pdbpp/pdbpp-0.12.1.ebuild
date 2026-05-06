# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..14} )

inherit distutils-r1 pypi

DESCRIPTION="A drop-in replacement for pdb that adds tab-completion, syntax highlighting, etc."
HOMEPAGE="
	https://github.com/pdbpp/pdbpp
	https://pypi.org/project/pdbpp/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/fancycompleter-0.11.0[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
