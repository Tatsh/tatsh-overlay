# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ps2-port

DESCRIPTION="zlib compression library for the PlayStation 2"
HOMEPAGE="https://zlib.net/ https://github.com/ps2dev/ps2sdk-ports"
SRC_URI="https://github.com/madler/zlib/releases/download/v${PV}/zlib-${PV}.tar.xz"
S="${WORKDIR}/zlib-${PV}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		-DUNIX=ON
		-DZLIB_BUILD_SHARED=OFF
		-DZLIB_BUILD_TESTING=OFF
	)
	ps2-port_src_configure
}
