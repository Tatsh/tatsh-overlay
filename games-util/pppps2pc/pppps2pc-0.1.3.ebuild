# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 udev

DESCRIPTION="Extremely simple tool to enable the ParaParaParadise PS2 controller on a PC."
HOMEPAGE="
	https://github.com/Tatsh/pppps2pc
	https://pypi.org/project/pppps2pc/
"
SRC_URI="https://github.com/Tatsh/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/bascom-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.3[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.15.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]"
BDEPEND="test? (
	dev-python/mock[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"

src_install() {
	distutils-r1_src_install
	udev_dorules 70-ppp.rules
	doman "man/${PN}.1"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}

distutils_enable_tests pytest
