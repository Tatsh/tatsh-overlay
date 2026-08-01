# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

NPM_PN="@${PN/-/\/}"

DESCRIPTION="VS Code extensions manager for extension developers."
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="BSD-2 MIT Apache-2.0 ISC PSF-2"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

BDEPEND+=" dev-libs/glib"
DEPEND="virtual/zlib"
RDEPEND="net-libs/nodejs:="

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/${NPM_PN}/vsce"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${NPM_PN}/vsce" "/usr/bin/vsce"
}
