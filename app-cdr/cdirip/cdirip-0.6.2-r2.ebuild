# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Converts DiscJuggler CDI files to various disc image formats."
HOMEPAGE="https://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/cdirip/down_cdi.html"
SRC_URI="https://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/${PN}/${PN}${PV//.}-src.zip"

S="${WORKDIR}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

BDEPEND="app-arch/unzip"

src_prepare() {
	sed -e '4s/.*/#include <string.h>/' -i buffer.c || die
	default
}

src_compile() {
	emake -f Makefile.linux "CC=$(tc-getCC)" "CFLAGS=${CFLAGS} -lm" || die "emake failed"
}

src_install() {
	dobin "${PN}"
}
