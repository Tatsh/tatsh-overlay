# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..15} )
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of git-up"
HOMEPAGE="https://github.com/msiemens/PyGitUp https://pypi.org/project/git-up/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-python/colorama-0.4[${PYTHON_USEDEP}]
	>=dev-python/gitpython-3.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-25.0[${PYTHON_USEDEP}]
	>=dev-python/termcolor-3.2[${PYTHON_USEDEP}]"

src_test() {
	local -x GIT_AUTHOR_NAME=test GIT_AUTHOR_EMAIL=test@example.com
	local -x GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@example.com
	distutils-r1_src_test
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
