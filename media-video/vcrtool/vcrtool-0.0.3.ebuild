# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="Control a JLIP device such as a VCR."
HOMEPAGE="
	https://github.com/Tatsh/vcrtool
	https://pypi.org/project/vcrtool/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/anyio-4.13.0[${PYTHON_USEDEP}]
	>=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.2[${PYTHON_USEDEP}]
	>=dev-python/psutil-7.2.2[${PYTHON_USEDEP}]
	>=dev-python/pyftdi-0.57.1[${PYTHON_USEDEP}]
	>=dev-python/pyrate-limiter-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
	>=dev-python/pytimeparse2-1.7.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	${RDEPEND}
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
