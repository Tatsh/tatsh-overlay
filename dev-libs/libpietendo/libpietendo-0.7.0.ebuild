# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library for parsing Nintendo file formats."
HOMEPAGE="https://github.com/jakcron/libpietendo"
SRC_URI="https://github.com/jakcron/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libfmt dev-libs/libtoolchain net-libs/mbedtls"
RDEPEND="${DEPEND}"

src_compile() {
	emake static_lib
}

src_install() {
	insinto /usr/include
	doins include/pietendo.h
	insinto /usr/include/pietendo
	doins -r include/pietendo/*
	dolib.a "bin/${PN}.a"
	einstalldocs
}
