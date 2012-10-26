# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Converts DiscJuggler CDI files to various disc image formats."
HOMEPAGE="http://files.tatsh.net/"
SRC_URI="http://files.tatsh.net/cdirip062-src.tar.bz2"

LICENSE="cdirip-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/cdirip062-src"

src_compile() {
  emake -e
}

src_install() {
  dobin cdirip
}
