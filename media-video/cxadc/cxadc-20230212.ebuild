# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit linux-info linux-mod udev

DESCRIPTION="CX2388x direct ADC capture driver."
HOMEPAGE="https://github.com/happycube/cxadc-linux3"
SHA="e20b2ade2b77fab2263dfa0c3363869f03bb3052"
SRC_URI="https://github.com/happycube/cxadc-linux3/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-linux3-${SHA}"

MODULE_NAMES="${PN}()"
BUILD_TARGETS="clean default leveladj"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"

src_prepare() {
	echo 'leveladj:' >> Makefile
	echo -e '\tcc $(CFLAGS) -o cxleveladj leveladj.c' >> Makefile
	default
}

src_install() {
	linux-mod_src_install
	udev_dorules "${PN}.rules"
	insinto /lib/modprobe.d
	doins "${PN}.conf"
	dobin utils/c* cxleveladj
	einstalldocs
}
