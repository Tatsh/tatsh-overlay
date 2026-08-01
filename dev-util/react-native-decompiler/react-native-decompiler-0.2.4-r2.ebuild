# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

DESCRIPTION="Decompile React Native bundles."
HOMEPAGE="https://github.com/numandev1/react-native-decompiler"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="MIT AGPL-3+ Apache-2.0 BSD-2 BSD ISC"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/out/main.js"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/out/main.js" "/usr/bin/${PN}"
}
