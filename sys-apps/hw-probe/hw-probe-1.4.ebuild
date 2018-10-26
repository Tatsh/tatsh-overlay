# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit perl-module

DESCRIPTION="A tool to probe system hardware, check operability and upload results"
HOMEPAGE="https://github.com/linuxhw/hw-probe"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/linuxhw/${PN}.git"
	SRC_URI=""
	KEYWORDS=""
	inherit git-r3
else
	SRC_URI="https://github.com/linuxhw/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="-* amd64 ~ppc x86 ~amd64-linux ~arm-linux ~x86-linux"
fi

LICENSE="LGPL-2"
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}
	>=dev-lang/perl-5.20
	net-misc/curl
	sys-apps/dmidecode
	sys-apps/hwinfo
	sys-apps/pciutils
	sys-apps/usbutils
"

src_prepare() {
	sed -i '\:^prefix :a\ dummy_build_folder := $(shell mkdir -p ${prefix})' \
		"${S}/Makefile" || die "sed failed"
	default
}

src_compile() {
	emake prefix="${D}usr"
}

src_install() {
	emake install prefix="${D}usr"
	default
}

pkg_postinst() {
	einfo "Recommended addtional packages to provide better hardware detection:"
	einfo "sys-apps/hdparm"
	einfo "sys-apps/inxi"
	einfo "sys-apps/smartmontools"
	einfo
}
