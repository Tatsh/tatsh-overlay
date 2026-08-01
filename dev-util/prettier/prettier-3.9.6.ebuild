# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

DESCRIPTION="Prettier is an opinionated code formatter."
HOMEPAGE="https://prettier.io"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/prettier/bin/${PN}.cjs"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/prettier/bin/${PN}.cjs" "/usr/bin/${PN}"
}
