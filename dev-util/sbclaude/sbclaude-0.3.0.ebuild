# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..14} )

PYPI_VERIFY_REPO="https://github.com/Tatsh/sbclaude"

inherit distutils-r1 pypi

DESCRIPTION="Run Claude Code in a throwaway Docker container."
HOMEPAGE="https://github.com/Tatsh/sbclaude"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-containers/docker-cli
	>=dev-python/bascom-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.5.0[${PYTHON_USEDEP}]
	>=dev-python/docker-7.2.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.11.7[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.15.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.16.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest
