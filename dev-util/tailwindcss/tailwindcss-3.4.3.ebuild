# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# nodejs_remove_dev deletes every directory called doc, and the yaml
# dependency keeps real sources in dist/doc, so the CLI fails to start with
# "Cannot find module '../doc/directives.js'" once they are gone.
NODEJS_KEEP_DEV_FILES=1

inherit nodejs-mod

DESCRIPTION="Utility-first CSS framework, as a standalone CLI."
HOMEPAGE="https://tailwindcss.com https://github.com/tailwindlabs/tailwindcss"
SRC_URI="https://github.com/Tatsh/tatsh-overlay/releases/download/__distfiles__/${P}-node_modules.tar.xz"
S="${WORKDIR}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"

src_install() {
	nodejs-mod_src_install

	local bin
	bin="/usr/$(get_libdir)/node_modules/${PN}/node_modules/${PN}/lib/cli.js"
	fperms 0755 "${bin}"
	dosym "../$(get_libdir)/node_modules/${PN}/node_modules/${PN}/lib/cli.js" \
		"/usr/bin/${PN}"
}
