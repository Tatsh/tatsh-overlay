# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="libretro-db tools from RetroArch."
HOMEPAGE="https://github.com/libretro/RetroArch/tree/master/libretro-db"
SRC_URI="https://github.com/libretro/RetroArch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/RetroArch-${PV}/${PN}"

src_configure() {
	:
}

src_install() {
	dobin libretrodb_tool
	local bin
	for bin in c_converter dat_converter; do
		newbin "$bin" "libretrodb-${bin}"
	done
	einstalldocs
}
