# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Fine tune write cache and buffer limits for USB storage devices."
HOMEPAGE="https://gitlab.manjaro.org/fhdk/udev-usb-sync"
SRC_URI="https://gitlab.manjaro.org/fhdk/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-apps/hdparm
	virtual/udev"

DOCS=( README.md )

src_install() {
	dobin "${PN}"
	insinto "/etc/${PN}"
	doins "${PN}.conf"
	udev_dorules 99-usb-sync.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
