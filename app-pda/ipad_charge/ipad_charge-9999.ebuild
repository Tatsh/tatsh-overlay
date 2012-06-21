# kate: replace-tabs false;
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils git-2

DESCRIPTION="Helper utility to enable charging with Apple mobile devices such as the iPad."
HOMEPAGE="https://github.com/mkorenkov/ipad_charge"
EGIT_REPO_URI="git://github.com/mkorenkov/ipad_charge.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:1"
RDEPEND="${DEPEND}"

src_install() {
	dodoc COPYING

	insinto /lib/udev/rules.d
	doins 95-ipad_charge.rules

	exeinto /usr/bin
	doexe ipad_charge
}
