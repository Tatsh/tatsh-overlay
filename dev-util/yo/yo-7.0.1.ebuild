# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

# rxjs ships dist/cjs/internal/operators/sample.js, which nodejs_remove_dev
# deletes as if it were a sample file.
NODEJS_KEEP_DEV_FILES=1

DESCRIPTION="CLI tool for running Yeoman generators."
HOMEPAGE="https://yeoman.io"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"
LICENSE="BSD-2 MIT Apache-2.0 CC0-1.0 0BSD BlueOak-1.0.0 CC-BY-3.0 ISC WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install
	fperms 0755 "/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/lib/cli.js"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/lib/cli.js" "/usr/bin/${PN}"
}
