# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-20120127.ebuild,v 1.9 2012/04/25 10:35:55 lxnay Exp $

EAPI="4"

inherit emul-linux-x86

LICENSE="GPL-3 GPL-2 LGPL-2 LGPL-2.1 FTL MIT || ( LGPL-2.1 MPL-1.1 )"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-20120127
	~app-emulation/emul-linux-x86-xlibs-20120127
	~app-emulation/emul-linux-x86-opengl-20120127
	>=app-emulation/emul-linux-x86-gtklibs-20120127"
# RDEPEND on opengl stuff shouldn't be needed, but add it anyway until bug #410213 is properly solved

IUSE=""
SRC_URI="http://files.tatsh.net/emul-linux-x86-wxGTK-20120505.tbz2"

src_prepare() {
	emul-linux-x86_src_prepare
}

src_install() {
	insinto /usr/lib32
	doins usr/lib/*
}
