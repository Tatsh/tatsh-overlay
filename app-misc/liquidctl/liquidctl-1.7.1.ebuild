# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1 udev

DESCRIPTION="Cross-platform CLI and Python drivers for AIO liquid coolers and other devices."
HOMEPAGE="https://github.com/liquidctl/liquidctl"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/hidapi[${PYTHON_USEDEP}]
	sys-apps/i2c-tools[${PYTHON_USEDEP},python]"

distutils_enable_tests pytest

python_prepare_all() {
	sed -e 's/, TAG+=".*/, GROUP="plugdev", MODE="0660"/g' \
		-i extra/linux/71-${PN}.rules || die "Failed to patch"
	distutils-r1_python_prepare_all
}

python_install_all() {
	default
	doman liquidctl.8
	udev_dorules extra/linux/71-${PN}.rules
}

pkg_postinst() {
	udev_reload
}
