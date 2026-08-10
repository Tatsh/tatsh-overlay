# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd toolchain-funcs udev

DESCRIPTION="CX2388x direct ADC capture driver."
HOMEPAGE="https://github.com/happycube/cxadc-linux3"
SHA="a5beb76d1aca6e6855f0cb37c94c1132d3d1d857"
SRC_URI="https://github.com/happycube/cxadc-linux3/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-linux3-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

MAKEOPTS+=" -j1"

DOCS=( README.md "Tips-&-Notes.md" )

src_compile() {
	local modlist=( "${PN}" )
	# Upstream builds the module via the 'cxadc' target; leveladj and levelmon
	# are ordinary userspace binaries built below.
	local modargs=( KDIR="${KERNEL_DIR}" "${PN}" )
	linux-mod-r1_src_compile
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" leveladj levelmon
}

src_install() {
	linux-mod-r1_src_install
	udev_dorules "${PN}.rules"
	insinto /lib/modprobe.d
	doins "${PN}.conf"
	dobin utils/c*
	newbin leveladj cxleveladj
	newbin levelmon cxlevelmon
	systemd_dounit "${PN}nc.service"
}
