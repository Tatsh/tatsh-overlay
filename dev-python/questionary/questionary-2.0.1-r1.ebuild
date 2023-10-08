# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to build command line user prompts."
HOMEPAGE="https://pypi.org/project/questionary/"
SRC_URI="https://github.com/tmbo/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/prompt-toolkit[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
