# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_1{0,1,2} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 systemd

DESCRIPTION="Helper commands to automate updating with Portage."
HOMEPAGE="https://github.com/Tatsh/upkeep"
SRC_URI="https://github.com/Tatsh/upkeep/archive/v${PV}.tar.gz -> ${P}.tar.gz"
IUSE="test"
RESTRICT="!test? ( test )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

BDEPEND="test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/Levenshtein[${PYTHON_USEDEP}]
	)"
RDEPEND="app-portage/eix
	app-portage/gentoolkit
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
	sys-kernel/dracut"

src_install() {
	distutils-r1_src_install
	systemd_dounit systemd/portage-sync.{service,timer}
	doman "man/${PN}.1"
}

pkg_postinst() {
	einfo
	einfo 'If you want GRUB support, you must have sys-boot/grub:2 installed.'
	einfo
}

distutils_enable_tests pytest
