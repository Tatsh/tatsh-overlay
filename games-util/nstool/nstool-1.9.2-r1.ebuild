# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="General purpose read/extract tool for Nintendo Switch file formats."
HOMEPAGE="https://github.com/jakcron/nstool"
SRC_URI="https://github.com/jakcron/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="app-arch/lz4
	net-libs/mbedtls:3
	dev-libs/libfmt
	dev-libs/libtoolchain
	dev-libs/libpietendo"
RDEPEND="${DEPEND}"

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/^(PROJECT_DEPEND.*)/\1 mbedcrypto-3/' \
		-e 's/@\$\(CXX\)/$(CXX)/g' \
		-e '/\t@echo .*/d' \
		-i makefile || die
	default
}

src_install() {
	dobin "bin/${PN}"
	einstalldocs
}
