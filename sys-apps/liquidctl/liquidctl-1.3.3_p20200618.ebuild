# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7,8} )
inherit distutils-r1 udev

DESCRIPTION="Cross-platform CLI and Python drivers for AIO liquid coolers and other devices."
HOMEPAGE="https://github.com/jonasmalacofilho/liquidctl"
MY_SHA="1f73bd07b853cfb95861e80314f1c350ef546bc3"
SRC_URI="https://github.com/jonasmalacofilho/${PN}/archive/${MY_SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pyusb[${PYTHON_USEDEP}]
	dev-python/hidapi[${PYTHON_USEDEP}]"
BDEPEND=""

S="${WORKDIR}/${PN}-${MY_SHA}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	sed -r 's/, TAG+=".*/, GROUP="plugdev", MODE="0660"/' \
		-i extra/linux/71-${PN}.rules
}

python_install_all() {
	default
	doman liquidctl.8
	udev_dorules extra/linux/71-${PN}.rules
}

pkg_postinst() {
	udev_reload
}
