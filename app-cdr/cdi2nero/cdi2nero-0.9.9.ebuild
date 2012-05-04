# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Converts DiscJuggler CDI files to NRG (Nero)."
HOMEPAGE="http://digitalimagecorp.de/software/cdi2nero/"
SRC_URI="http://files.tatsh.net/cdi2nero099-src.tar.bz2"

LICENSE="cdi2nero-eula"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/cdi2nero099-src"

src_compile() {
  emake -e
}

src_install() {
  dobin cdi2nero
}
