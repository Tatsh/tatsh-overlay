# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Converts DiscJuggler CDI files to NRG (Nero)."
HOMEPAGE="http://digitalimagecorp.de/software/cdi2nero/"
SRC_URI="https://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/cdirip/${PN}${PV//.}-src.zip"

S="${WORKDIR}"
LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

PATCHES=( "${FILESDIR}/${PN}.patch" )

BDEPEND="app-arch/unzip"

src_compile() {
	emake -f "Makefile.${PN}.posix" || die "emake failed"
}

src_install() {
	dobin "${PN}"
}
