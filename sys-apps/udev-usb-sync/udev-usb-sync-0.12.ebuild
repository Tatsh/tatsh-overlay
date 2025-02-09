# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev

DESCRIPTION="Fine tune write cache and impose buffer limits when USB storage device is plugged."
HOMEPAGE="https://gitlab.manjaro.org/fhdk/udev-usb-sync"
SRC_URI="https://gitlab.manjaro.org/fhdk/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="sys-apps/hdparm
	virtual/udev"

DOCS=( README.md )

S="${WORKDIR}/${PN}-v${PV}"

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
