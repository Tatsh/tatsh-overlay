# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-r3 toolchain-funcs

DESCRIPTION="Hack for Apple's Superdrive to work with other systems than OS X."
HOMEPAGE="https://github.com/onmomo/superdrive-enabler"
EGIT_REPO_URI="git://github.com/onmomo/superdrive-enabler.git"
EGIT_COMMIT="809e81ed19af1acc776b88f91c05c4763f3665ac"

LICENSE="MIT" # ? https://github.com/onmomo/superdrive-enabler/issues/1
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	# Makefile does too much, so compile manually here
	$(tc-getCC) -o ${PN} ${CFLAGS} ${LDFLAGS} src/superdriveEnabler.c
}

src_install() {
	exeinto /usr/bin
	doexe ${PN}
}

pkg_postinst() {
	einfo
	einfo "To unlock a SuperDrive device, type:"
	einfo
	einfo "${PN} <DEVICE_PATH>"
	einfo
	einfo "(such as /dev/sr0)"
	einfo
}
