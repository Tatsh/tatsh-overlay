# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Converts DiscJuggler CDI files to NRG (Nero)."
HOMEPAGE="http://digitalimagecorp.de/software/cdi2nero/"
SRC_URI="http://web.archive.org/web/20091027063725/http://es.geocities.com/dextstuff/cdirip/cdi2nero099-src.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	eapply -p0 "${FILESDIR}/${PN}.patch"
	default
}

src_install() {
	dobin "${PN}"
}
