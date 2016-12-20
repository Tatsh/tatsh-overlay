# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit git-r3

DESCRIPTION="Sega Dreamcast emulator."
HOMEPAGE="http://reicast.com/"
EGIT_REPO_URI="https://github.com/reicast/reicast-emulator.git"
EGIT_COMMIT="aca9cb6919206ef104f4827e04106a1312f0ab71"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/alsa-lib-1.0.29
	>=x11-base/xorg-server-1.12.4-r5"
RDEPEND="${DEPEND}"

src_compile () {
	emake -C shell/linux platform=x64
}

src_install () {
	cd "${S}/shell/linux"
	doman man/*.1
	domenu "${PN}.desktop"
	exeinto /usr/bin
	cp reicast.elf reicast
	doexe reicast tools/reicast-joyconfig.py
	doicon "${PN}.png"
}
