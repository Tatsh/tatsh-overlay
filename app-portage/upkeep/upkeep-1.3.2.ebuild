# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9,10,11} )

inherit distutils-r1

DESCRIPTION="Helper commands to automate updating with Portage."
HOMEPAGE="https://github.com/Tatsh/upkeep"
SRC_URI="https://github.com/Tatsh/upkeep/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-portage/eix
	app-portage/gentoolkit
	sys-kernel/dracut"

pkg_postinst() {
	einfo
	einfo 'If you want GRUB support, you must have sys-boot/grub:2 installed.'
	einfo
}
