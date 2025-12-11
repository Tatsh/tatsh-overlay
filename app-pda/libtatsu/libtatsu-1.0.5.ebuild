# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library handling the communication with Apple's Tatsu Signing Server (TSS)."
HOMEPAGE="https://github.com/libimobiledevice/libtatsu"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=app-pda/libplist-2.6.0
	net-misc/curl"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	RELEASE_VERSION=${PV} eautoreconf
}

src_configure() {
	econf --disable-static
}

src_install() {
	default
	rm "${D}/usr/$(get_libdir)/${PN}.la" || die
}
