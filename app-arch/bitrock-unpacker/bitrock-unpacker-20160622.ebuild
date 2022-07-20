# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bitrock unpacking script."
HOMEPAGE="https://gist.github.com/mickael9/0b902da7c13207d1b86e"
SRC_URI="https://gist.githubusercontent.com/mickael9/0b902da7c13207d1b86e/raw/ef65b6583c5cf077fb897a9a028781f577fed9ac/bitrock-unpacker.tcl -> ${P}.tcl"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-tcltk/sdx"

S="${WORKDIR}"

src_unpack() {
	:
}

src_install() {
	newbin "${DISTDIR}/${P}.tcl" "${PN}"
}
