# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Utility for decrypt, encrypt and sign PS2 KELF and PSX KELF files."
HOMEPAGE="https://github.com/parrado/kelftool"
SHA="befdc6b103cedae7ba11ba55b28bdd6f60f90533"
SRC_URI="https://github.com/parrado/kelftool/archive/${SHA}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${SHA}"

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
