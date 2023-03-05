# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="Common code used by libimobiledevice project.."
HOMEPAGE="https://github.com/libimobiledevice/libimobiledevice-glue"
SHA="6fcb8794592c8b275e615a6bc863c8c10e978174"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="udev"

DEPEND="sys-libs/readline
	virtual/libusb:1"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	rm "${D}/usr/$(get_libdir)/${PN}-1.0.la" || die
}
