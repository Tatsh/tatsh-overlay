# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Converts UIF disc format to ISO."
HOMEPAGE="http://aluigi.altervista.org/"
SRC_URI="http://files.tatsh.net/$PN-$PV.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/$PN-$PV/src"

src_compile() {
  emake -e
}

src_install() {
  dobin "$PN"

  cd ..
  dodoc README "$PN.txt"
}
