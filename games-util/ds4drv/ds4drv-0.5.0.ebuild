# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 python3_3 )

inherit distutils-r1

DESCRIPTION="A Sony DualShock 4 userspace driver for Linux"
HOMEPAGE="https://pypi.python.org/pypi/ds4drv"
SRC_URI="https://pypi.python.org/packages/source/d/ds4drv/ds4drv-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-python/pyudev-0.16.1
	>=dev-python/python-evdev-0.3.0
"

python_install() {
	insinto /lib/udev/rules.d
	echo 'KERNEL=="uinput", MODE="0666"' > 50-ds4drv.rules
	echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"' >> 50-ds4drv.rules
	echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"' >> 50-ds4drv.rules
	doins 50-ds4drv.rules
	/sbin/udevadm control --reload-rules

	distutils-r1_python_install
}
