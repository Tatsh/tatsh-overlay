# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit linux-info toolchain-funcs

DESCRIPTION="Hack for Apple's Superdrive to work with other systems than OS X."
HOMEPAGE="https://github.com/onmomo/superdrive-enabler"
SHA="c5e430077d361283311080fd1ff4cb94e6896553"
SRC_URI="https://github.com/onmomo/superdrive-enabler/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+udev"

CONFIG_CHECK="~BLK_DEV_SR"

src_prepare() {
	sed -e '7s/\(.*\)/#include <unistd.h>/' -i src/superdriveEnabler.c
	default
}

src_compile() {
	emake CCMD=$(tc-getCC) \
		OUTPUT_PATH="$(pwd -P)/" \
		CXXFLAGS="$CXXFLAGS" \
		LDFLAGS="$LDFLAGS"
}

src_install() {
	dobin ${PN}
	einstalldocs
	if use udev; then
		insinto /lib/udev/rules.d
		doins "${FILESDIR}/90-superdrive.rules"
		udevadm control --reload-rules
	fi
}

pkg_postinst() {
	if ! use udev; then
		einfo
		einfo "To unlock a SuperDrive device manually, type:"
		einfo
		einfo "${PN} <DEVICE_PATH>"
		einfo
		einfo "(such as /dev/sr0)"
		einfo
	fi
}
