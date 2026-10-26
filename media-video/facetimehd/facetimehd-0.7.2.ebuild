# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="Reverse engineered Linux driver for the FacetimeHD (Broadcom 1570) PCIe webcam"
HOMEPAGE="https://github.com/patjak/facetimehd"
SRC_URI="https://github.com/patjak/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CONFIG_CHECK="PCI VIDEO_DEV VIDEOBUF2_DMA_SG"
ERROR_VIDEOBUF2_DMA_SG="CONFIG_VIDEOBUF2_DMA_SG is not set. It cannot be enabled directly; enable a
driver that selects it, for example CONFIG_VIDEO_VIVID."

pkg_setup() {
	linux-mod-r1_pkg_setup
}

src_compile() {
	local modlist=( facetimehd )
	local modargs=( KDIR="${KV_OUT_DIR}" )
	linux-mod-r1_src_compile
}

pkg_postinst() {
	linux-mod-r1_pkg_postinst
	elog "The camera also needs its firmware, which Apple ships only inside its Boot Camp"
	elog "drivers. Extract it with https://github.com/patjak/facetimehd-firmware and install it"
	elog "as /lib/firmware/facetimehd/firmware.bin."
}
