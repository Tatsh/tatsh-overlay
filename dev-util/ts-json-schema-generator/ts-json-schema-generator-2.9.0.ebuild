# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nodejs-mod

DESCRIPTION="Generate JSON Schema from TypeScript types."
HOMEPAGE="https://github.com/vega/ts-json-schema-generator"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install
	local bin="/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/bin/${PN}.js"
	fperms 0755 "${bin}"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/bin/${PN}.js" \
		"/usr/bin/${PN}"
}
