# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ps2-port

DESCRIPTION="JPEG image codec for the PlayStation 2"
HOMEPAGE="https://libjpeg-turbo.org/ https://github.com/ps2dev/ps2sdk-ports"
SRC_URI="https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/${PV}/libjpeg-turbo-${PV}.tar.gz"
S="${WORKDIR}/libjpeg-turbo-${PV}"

LICENSE="BSD IJG ZLIB"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		-DENABLE_SHARED=OFF
		-DWITH_SIMD=OFF
		-DWITH_TOOLS=OFF
	)
	ps2-port_src_configure
}
