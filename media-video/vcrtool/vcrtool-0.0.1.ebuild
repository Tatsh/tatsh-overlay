# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_1{0,1,2,3} )
inherit distutils-r1 pypi

DESCRIPTION="Control a JLIP device such as a VCR."
HOMEPAGE="https://pypi.org/project/vcrtool/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pyftdi[${PYTHON_USEDEP}]
	dev-python/pyrate-limiter[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/pytimeparse2[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install
	doman "man/${PN}.1"
}

distutils_enable_tests pytest
