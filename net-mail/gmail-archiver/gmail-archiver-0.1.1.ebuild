# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Locally archive Gmail emails."
HOMEPAGE="
	https://github.com/Tatsh/gmail-archiver
	https://pypi.org/project/gmail-archiver/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/aioimaplib-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/niquests-3.18.6[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.6[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}
