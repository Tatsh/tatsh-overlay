# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-mod git-2

DESCRIPTION="iPhone USB ethernet driver (personal hotspot)"
HOMEPAGE="https://github.com/Tatsh/ipheth"
EGIT_REPO_URI="git://github.com/Tatsh/ipheth.git"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="udev"

DEPEND="udev? ( app-pda/libimobiledevice )"
RDEPEND="${DEPEND}
	udev? ( virtual/udev )"

CONFIG_CHECK="!USB_IPHETH !COMPAT_NET_DEV_OPS"
MODULE_NAMES="ipheth(usb:${S}/${PN}-driver:${S}/${PN}-driver)"
BUILD_TARGETS="all"

src_compile() {
	linux-mod_src_compile

	if use udev; then
		pushd ${S}/${PN}-pair 2>&1 > /dev/null
		sed -e 's/^CFLAGS\s\+.*//' -i Makefile # Strip the unwanted CFLAGS out
		emake
		popd 2>&1 > /dev/null
	fi
}

src_install() {
	linux-mod_src_install

	if use udev; then
		pushd ${S}/${PN}-pair 2>&1 > /dev/null

		dobin ${PN}-pair
		insinto /lib/udev/rules.d
		doins 90-iphone-tether.rules
		/sbin/udevadm control --reload-rules

		popd 2>&1 > /dev/null
	fi
}

# kate: replace-tabs false;
