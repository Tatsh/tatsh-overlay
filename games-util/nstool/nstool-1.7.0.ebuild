# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="General purpose read/extract tool for Nintendo Switch file formats."
HOMEPAGE="https://github.com/jakcron/nstool"
SRC_URI="https://github.com/jakcron/${PN}/archive/refs/tags/v${PV}-r2.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/lz4 net-libs/mbedtls dev-libs/libfmt dev-libs/libtoolchain dev-libs/libpietendo"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-r2"

src_prepare() {
	sed -re 's/^(PROJECT_DEPEND.*)/\1 mbedcrypto/' -i makefile || die
	default
}

src_install() {
	dobin "bin/${PN}"
	einstalldocs
}
