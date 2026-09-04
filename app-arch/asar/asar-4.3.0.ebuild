# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

DESCRIPTION="Create Electron app packages."
HOMEPAGE="https://github.com/electron/asar"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/@electron/asar/bin/${PN}.mjs"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/@electron/asar/bin/${PN}.mjs" "/usr/bin/${PN}"
}
