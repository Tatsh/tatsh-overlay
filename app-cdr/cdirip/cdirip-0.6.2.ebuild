# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Converts DiscJuggler CDI files to various disc image formats."
HOMEPAGE="https://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/cdirip/down_cdi.html"
SRC_URI="https://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/cdirip/cdirip062-src.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	sed -e '4s/.*/#include <string.h>/' -i buffer.c
	default
}

src_compile() {
	emake -f Makefile.linux CFLAGS="${CFLAGS}"
}

src_install() {
	dobin "${PN}"
}
