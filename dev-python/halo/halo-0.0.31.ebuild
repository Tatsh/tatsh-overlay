# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Beautiful spinners for terminal, IPython and Jupyter."
HOMEPAGE="https://pypi.org/project/halo/ https://github.com/manrajgrover/halo"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/log-symbols-0.0.14
	>=dev-python/spinners-0.0.24
	>=dev-python/termcolor-1.1.0
	>=dev-python/colorama-0.3.9
	>=dev-python/six-1.12.0
"

distutils_enable_tests pytest
