# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Helper utility to enable charging with Apple mobile devices such as the iPad."
HOMEPAGE="https://github.com/Tatsh/ipad_charge"
SRC_URI="https://github.com/Tatsh/ipad_charge/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

DOCS=( COPYING README.md )

src_install() {
	dobin ipad_charge
	insinto /lib/udev/rules.d
	doins udev/95-ipad_charge.rules
	einstalldocs
}
# kate: replace-tabs false;
