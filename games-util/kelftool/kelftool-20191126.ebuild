# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility for decrypt, encrypt and sign PS2 KELF and PSX KELF files."
HOMEPAGE="https://github.com/parrado/kelftool"
SHA="6b9b471388626c4a576c7d7d67b8664c00fcd024"
SRC_URI="https://github.com/parrado/kelftool/archive/${SHA}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SHA}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -re "s/^(CXXFLAGS =.*)/\1 ${CFLAGS}/" \
		-e "s/^(LDLIBS = .*)/\1 ${LDFLAGS}/" \
		-i Makefile
	default
}

src_install() {
	einstalldocs
	newbin "build/${PN}.elf" "${PN}"
}
