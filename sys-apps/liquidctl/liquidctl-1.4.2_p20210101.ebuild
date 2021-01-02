# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{7,8,9} )
inherit distutils-r1 udev

DESCRIPTION="Cross-platform CLI and Python drivers for AIO liquid coolers and other devices."
HOMEPAGE="https://github.com/jonasmalacofilho/liquidctl"
MY_SHA="30dd13e4deff0e4c78f8fb932e87705b705c87a5"
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
