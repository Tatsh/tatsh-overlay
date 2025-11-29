# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 systemd udev

DESCRIPTION="CX2388x direct ADC capture driver."
HOMEPAGE="https://github.com/happycube/cxadc-linux3"
SHA="f1569ab64b4817400e561956896f9bfba492e594"
SRC_URI="https://github.com/happycube/cxadc-linux3/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-linux3-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

MAKEOPTS+=" -j1"

DOCS=( README.md "Tips-&-Notes.md" )

src_prepare() {
	echo 'leveladj:' >> Makefile
	# shellcheck disable=SC2016
	echo -e '\tcc $(CFLAGS) -o cxleveladj leveladj.c' >> Makefile
	default
}

src_compile() {
	local modlist=( "${PN}" )
	local modargs=( KDIR="${KERNEL_DIR}" clean default leveladj )
	linux-mod-r1_src_compile
}

src_install() {
	linux-mod-r1_src_install
	udev_dorules "${PN}.rules"
	insinto /lib/modprobe.d
	doins "${PN}.conf"
	dobin utils/c*
	newbin leveladj cxleveladj
	systemd_dounit "${PN}nc.service"
}
