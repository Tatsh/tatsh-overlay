# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-info linux-mod git-2

DESCRIPTION="iPhone USB ethernet driver (personal hotspot)"
HOMEPAGE="https://github.com/dgiagio/ipheth"
EGIT_REPO_URI="git://github.com/dgiagio/ipheth.git"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="udev"

DEPEND="udev? ( app-pda/libimobiledevice )"
RDEPEND="${DEPEND}
	udev? ( virtual/udev )"

CONFIG_CHECK="!USB_IPHETH !COMPAT_NET_DEV_OPS"
MODULE_NAMES="ipheth(usb:${S}/${PN}-driver:${S}/${PN}-driver)"
BUILD_TARGETS='all'

src_prepare() {
	cd ${S}/${PN}-driver
	# Avoid "make jobserver unavailable" warning and -Werror problems
	sed -e 's:\tmake:\t+make:g' \
		-i Makefile || die "sed failed"
}

src_compile() {
	KERNEL_DIR="/lib/modules/${KV_FULL}/build" linux-mod_src_compile

	if use udev; then
		pushd ${S}/${PN}-pair 2>&1 > /dev/null
		sed -e 's/^CFLAGS\s\+.*//' -i Makefile # Strip the unwanted CFLAGS out
		emake KERNELDIR=/lib/modules/${KV_FULL}/build || die "emake failed (udev)"
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
