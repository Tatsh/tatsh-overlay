# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Decrypt Wii U NUS content"
HOMEPAGE="https://github.com/VitaSmith/cdecrypt"
SRC_URI="https://github.com/VitaSmith/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/openssl"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/^LDFLAGS=.*//g' Makefile || die
	default
}

src_compile() {
	emake V=1
}

src_install() {
	einstalldocs
	dobin "${PN}"
}
