# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Toolchain development library."
HOMEPAGE="https://github.com/jakcron/libtoolchain"
SRC_URI="https://github.com/jakcron/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libfmt net-libs/mbedtls"
RDEPEND="${DEPEND}"

src_prepare() {
	# shellcheck disable=SC2016
	sed -re 's/@\$\(C(XX|C)/$(C\1/g' -i makefile || die
	default
}

src_compile() {
	emake static_lib
}

src_install() {
	dolib.a "bin/${PN}.a"
	insinto /usr/include
	doins -r include/*
	einstalldocs
}
