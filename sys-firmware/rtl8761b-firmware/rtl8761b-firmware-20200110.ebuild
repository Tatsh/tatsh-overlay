# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Firmware for the Realtek RTL8761B Bluetooth chipset."
HOMEPAGE="https://github.com/Realtek-OpenSource/android_hardware_realtek"
MY_SHA="e58b611f34f2f5ff57bb0d8cdf1b2e4751e3ccbd"
MY_PREFIX="${PN%-*}"
SRC_URI="https://github.com/Realtek-OpenSource/android_hardware_realtek/raw/${MY_SHA}/bt/rtkbt/Firmware/BT/${MY_PREFIX}_fw
	https://github.com/Realtek-OpenSource/android_hardware_realtek/raw/${MY_SHA}/bt/rtkbt/Firmware/BT/${MY_PREFIX}_config"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

S=${DISTDIR}

src_install() {
	insinto /lib/firmware/rtl_bt
	newins "${MY_PREFIX}_fw" "${MY_PREFIX}_fw.bin"
	newins "${MY_PREFIX}_config" "${MY_PREFIX}_config.bin"
}
